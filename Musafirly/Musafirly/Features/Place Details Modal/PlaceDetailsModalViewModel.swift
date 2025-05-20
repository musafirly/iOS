//
//  PlaceDetailsModalViewModel.swift
//  Musafirly
//
//  Created by Anthony on 5/1/25.
//

import Foundation
import SwiftUI
import SwiftData

class PlaceDetailsModalViewModel: ObservableObject {
    @Published var fullPlaceDetails: Place = Place.defaultPlace
    @Published var isCached: Bool = false
    @Published var isLoading: Bool = true
    
    let placeId: String
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    func tryLoadCachedPlaceDetails(_ context: ModelContext) throws {
        let predicate = FavoritePlace.searchForPlacePredicate(withPlaceId: placeId)
        let fetchDescriptor = FetchDescriptor<FavoritePlace>(predicate: predicate)

        do {
            let cachedPlaceDetails: [FavoritePlace] = try context.fetch(fetchDescriptor)

            guard let cachedPlace = cachedPlaceDetails.first else {
                isCached = false
                
                return
            }
            
            isCached = true
            
            self.fullPlaceDetails = Place(from: cachedPlace)
        } catch {
            print("Error fetching cached place details: \(error)")
        }
    }
    
    
    func saveFavorite(_ context: ModelContext) {
        guard !isCached else {
            print("Place \(fullPlaceDetails.summary.placeId) is marked as cached.")
            return
        }
        
        print("Caching place with id \(fullPlaceDetails.summary.placeId)")
        
        let favoritedPlace = FavoritePlace(fullPlaceDetails)
        
        context.insert(favoritedPlace)

        isCached = true
    }

    func removeFavorite(_ context: ModelContext) {
         do {
             print("Attempting to delete favorite with id \(placeId)")

             try context.delete(model: FavoritePlace.self, where: FavoritePlace.searchForPlacePredicate(withPlaceId: placeId))
             
             isCached = false
         } catch {
             print("Error deleting favorite: \(error)")
         }
     }
    
    
    @MainActor
    func fetchPlaceDetails() async throws {
        
        let endpointUrl: URL = .init(string: "https://api.musafirly.com/places/\(placeId)")!

        
        print("Calling Musafirly API for place id \(placeId)")
        
        let (data, response) = try await URLSession.shared.data(from: endpointUrl)
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            return print("Server error: \(response.debugDescription)")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let decodedPlaceDetails = try decoder.decode(Place.self, from: data)
        
        
        self.fullPlaceDetails = decodedPlaceDetails
        
        
        if fullPlaceDetails.summary.halalScore == nil {
            do {
                print("Creating halal calculate job for place: \(fullPlaceDetails.summary.name)")
                
                try await createHalalCalculateJob(forId: fullPlaceDetails.summary.placeId)
            } catch {
                print("Error creating halal calculate job: \(error.localizedDescription)")
            }
        }
    }
    
    func createHalalCalculateJob(forId: String) async throws {
        let baseUrl = URL(string: "https://api.musafirly.com/jobs")!
        
        let data: [String: Any] = [
            "payload" : [
                "place_id": forId
            ],
            "type": "calc"
        ]
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            return print("Server error: \(response.debugDescription)")
        }
    }
}
