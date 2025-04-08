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
        centerCoordinate: .init(latitude: 40.7685, longitude: -73.9822),
        distance: 1500))
    
    @Published var currentLocation: Location = .newYork
    
    @Published var markerLocations: [Location] = []
    
    
    init() {
        FindNearbyRestaurants()
    }

    
    func FindNearbyRestaurants() {
        
        let baseUrl = URL(string: "https://api.musafirly.com/places/nearby")!
        
        let urlWithLocation = baseUrl.appending(queryItems: [
            .init(name: "lat", value: String(currentLocation.latitude)),
            .init(name: "lon", value: String(currentLocation.longitude)),
        ])
        
        let task = URLSession.shared.dataTask(with: urlWithLocation) { (data, response, error) in
            if let error {
                return print("\(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return print("Server error: \(response!.debugDescription)")
            }
            
            guard let dataResponse = data else {
                return print("No Data Received")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedJsonLocations = try decoder.decode([Location].self, from: dataResponse)
                
                print("Decoded locations from Musafirly API: \(String(describing: decodedJsonLocations))")

                // Dispatch a closure to set markerLocations with the fetched nearby locations
                // Could just use async await to solve this, but this is more fun and allows slow fetches to not block map rendering.
                DispatchQueue.main.async {
                    self.markerLocations = decodedJsonLocations
                }
                
            } catch {
                print("Decoding Error")
            }
        }
        
        task.resume()
    }
}
