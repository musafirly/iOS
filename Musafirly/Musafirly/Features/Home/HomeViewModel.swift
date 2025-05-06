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
    
    @Published var currentPlace: PlaceSummary = .newYork
    
    @Published var markerPlaces: [PlaceSummary] = []

    
    @MainActor
    func FindNearbyRestaurants() async throws {
        
        let baseUrl = URL(string: "https://api.musafirly.com/places/nearby")!
        
        let urlWithPlace = baseUrl.appending(queryItems: [
            .init(name: "lat", value: String(currentPlace.latitude)),
            .init(name: "lon", value: String(currentPlace.longitude)),
            .init(name: "limit", value: "20"),
            .init(name: "radius", value: "1000")
        ])
        
        print("Calling Musafirly API for nearby places...")
        
        let (data, response) = try await URLSession.shared.data(from: urlWithPlace)
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            return print("Server error: \(response.debugDescription)")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let nearbyPlaces = try decoder.decode([PlaceSummary].self, from: data)
        
        
        self.markerPlaces = nearbyPlaces
    }
}
