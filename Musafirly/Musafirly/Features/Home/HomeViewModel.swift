//
//  HomeViewModel.swift
//  Musafirly
//
//  Created by Anthony on 3/12/25.
//

import Foundation
import SwiftUI
import MapKit


class HomeViewModel: ObservableObject {
    @Published var mapPos: MapCameraPosition = .camera(.init(
        centerCoordinate: .init(
            latitude: PlaceSummary.newYork.latitude,
            longitude: PlaceSummary.newYork.longitude),
        distance: 1500))
    
    
    @Published var selectedPlace: PlaceSummary?
    @Published var showDetailsModal: Bool = false
    
    @Published var markerPlaces: [PlaceSummary] = []
    @Published var mapError: IdentifiableError?
    
    @Published var loadingNewPlaces: Bool = false
    
    @Published var holdingScreen: Bool = false
    
    
    private var debounceTimer: Timer?
    private let debounceInterval: TimeInterval = 1
    
    
    deinit {
        // Invalidate timer if view gets destroyed
        debounceTimer?.invalidate()
    }

    
    // Handle map changes and handle timer logic in the ViewModel.
    func mapCameraDidChange(_ context: MapCameraUpdateContext) {
        let oldCameraCenter = mapPos.camera?.centerCoordinate
        
        mapPos = .camera(context.camera)
        
        print(holdingScreen)
        
        if self.holdingScreen {
            return
        }
        
        // Only fetch new locations if we moved positions, excluding zooming in or out.
        if let newCameraCenter = mapPos.camera?.centerCoordinate,
           oldCameraCenter != newCameraCenter
        {
            
            debounceTimer?.invalidate()
            
            
            self.loadingNewPlaces = true
            
            
            debounceTimer = Timer.scheduledTimer(
                withTimeInterval: debounceInterval,
                repeats: false
            ) { [weak self] timer in
                // [weak self] avoids a Retain Cycle, which is when two selves are used within a closure, leading to a closure's self not being deallocated, causing a memory leak.
                guard let self = self else {
                    print("ViewModel self is nil when timer fired. Timer block exiting.")
                    return
                }
                
                print("Timer fired! Starting FindNearbyRestaurants()...")
                
                
                Task { @MainActor in
                    
                    do {
                        try await self.FindNearbyRestaurants()
                        self.mapError = nil
                    } catch let error {
                        print("Error updating nearby restaurants on map: \(error)")
                        
                        self.mapError = IdentifiableError(error: error)
                    }
                }
            }
        }
    }
    
    
    @MainActor
    func FindNearbyRestaurants() async throws {
        
        let baseUrl = URL(string: "https://api.musafirly.com/places/nearby")!
        
        let searchLocation = mapPos.camera?.centerCoordinate
        
        if searchLocation == nil {
            return print("Error: Could not get current location from map.")
        }
        
        let urlWithPlace = baseUrl.appending(queryItems: [
            .init(name: "lat", value: String(searchLocation!.latitude)),
            .init(name: "lon", value: String(searchLocation!.longitude)),
            .init(name: "limit", value: "20"),
            .init(name: "radius", value: "1000")
        ])
        
        print("Calling Musafirly API for nearby places...")
        
        self.loadingNewPlaces = true
        
        let (data, response) = try await URLSession.shared.data(from: urlWithPlace)
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            return print("Server error: \(response.debugDescription)")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let nearbyPlaces = try decoder.decode([PlaceSummary].self, from: data)
        
        
        self.markerPlaces = nearbyPlaces
        
        self.loadingNewPlaces = false
    }
}
