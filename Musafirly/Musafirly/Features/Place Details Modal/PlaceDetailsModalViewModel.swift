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
    
    var fullAddress: String?
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    func tryLoadCachedPlaceDetails(_ context: ModelContext) throws {
        let predicate = FavoritePlace.searchForPlacePredicate(withPlaceId: fullPlaceDetails.summary.placeId)
        let fetchDescriptor = FetchDescriptor<FavoritePlace>(predicate: predicate)

        do {
            let cachedPlaceDetails: [FavoritePlace] = try context.fetch(fetchDescriptor)

            guard let cachedPlace = cachedPlaceDetails.first else {
                isCached = false
                
                print("Place is not cached.")
                
                return
            }
            
            isCached = true
            
            // This is the result stemming from 5 hours of me banging my head against a wall trying to
            //  properly save a custom struct (Place)'s properties using SwiftData, which I gave up on.
            //  - Anthony
            self.fullPlaceDetails = Place(
                summary: PlaceSummary(
                    id: cachedPlace.favoriteId,
                    name: cachedPlace.name,
                    placeDescription: cachedPlace.placeDescription,
                    latitude: cachedPlace.latitude,
                    longitude: cachedPlace.longitude,
                    phone: cachedPlace.phone,
                    website: cachedPlace.website,
                    reviewCount: cachedPlace.reviewCount,
                    reviewRating: cachedPlace.reviewRating,
                    reviewsPerRating: cachedPlace.reviewsPerRating,
                    thumbnailUrl: cachedPlace.thumbnailUrl,
                    openingHours: cachedPlace.openingHours,
                    priceRange: cachedPlace.priceRange,
                    timezone: cachedPlace.timezone,
                    link: cachedPlace.link,
                    popularTimes: cachedPlace.popularTimes,
                    distanceMeters: cachedPlace.distanceMeters
                ),
                about: cachedPlace.about,
                completeAddress: cachedPlace.completeAddress,
                owners: cachedPlace.owners,
                categories: cachedPlace.categories,
                images: cachedPlace.images,
                links: cachedPlace.links,
                reviews: cachedPlace.reviews
            )
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
             print("Attempting to delete favorite with id \(fullPlaceDetails.summary.placeId)")

             try context.delete(model: FavoritePlace.self, where: FavoritePlace.searchForPlacePredicate(withPlaceId: fullPlaceDetails.summary.placeId))
             
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
        
        if let addressDict = fullPlaceDetails.completeAddress {
            let street = addressDict["street"]
            let city = addressDict["city"]
            let state = addressDict["state"]
            
            fullAddress = "\(street ?? ""), \(city ?? ""), \(state ?? "")"
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
