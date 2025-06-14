//
//  FullPlaceDetailsViewModel.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import Foundation
//import SwiftUI
import SwiftData

class FullPlaceDetailsViewModel: ObservableObject {
    @Published var showError: Bool = false
    @Published var isFavorited: Bool = false
    @Published var isLoading: Bool = true
    
    @Published var place: Place = Place.defaultPlace
    
    private let placeId: String
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    
    func fetchIfPlaceFavorited(_ modelContext: ModelContext) throws {
        let descriptor = FetchDescriptor(predicate: FavoritePlace.searchForPlacePredicate(withPlaceId: placeId))
                                         
        let fetchResults: [FavoritePlace] = try modelContext.fetch(descriptor)
        
        
        if let favorite = fetchResults.first {
            self.place = Place(from: favorite)
            self.isFavorited = true
            self.isLoading = false
        } else {
            self.isFavorited = false
        }
    }
    
    
    func saveFavorite(_ modelContext: ModelContext) {
        guard !isFavorited else {
            print("Place \(place.summary.placeId) is marked as cached.")
            return
        }
        
        print("Caching place with id \(place.summary.placeId)")
        
        modelContext.insert(FavoritePlace(place))

        self.isFavorited = true
    }

    
    func removeFavorite(_ modelContext: ModelContext) {
        do {
            print("Attempting to delete favorite with id \(place.summary.placeId)")

            try modelContext.delete(model: FavoritePlace.self, where: FavoritePlace.searchForPlacePredicate(withPlaceId: place.summary.placeId))
         
            self.isFavorited = false
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
        
        self.place = decodedPlaceDetails
        
        if place.summary.halalScore == nil {
            do {
                print("Creating halal calculate job for place: \(place.summary.name)")
                
                try await createHalalCalculateJob(forId: place.summary.placeId)
            } catch {
                print("Error creating halal calculate job: \(error.localizedDescription)")
            }
        }
        
        self.isLoading = false
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
