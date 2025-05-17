//
//  ExploreViewModel.swift
//  Musafirly
//
//  Created by Anthony on 5/6/25.
//

import SwiftUI
import SwiftData

class ExploreViewModel: ObservableObject {
    @Published var favoritedPlaces: [Place] = []

    
    func fetchFavoritedPlaces(_ context: ModelContext) throws {
        let descriptor = FetchDescriptor<FavoritePlace>(
            predicate: .true,
            sortBy: [.init(\FavoritePlace.favoriteDate, order: .forward)]
        )
        
        do {
            
            let queriedPlaces = try context.fetch(descriptor)
            
            self.favoritedPlaces = queriedPlaces.map({ favorite in
                Place(
                    summary: PlaceSummary(
                        id: favorite.favoriteId,
                        name: favorite.name,
                        placeDescription: favorite.placeDescription,
                        latitude: favorite.latitude,
                        longitude: favorite.longitude,
                        phone: favorite.phone,
                        website: favorite.website,
                        reviewCount: favorite.reviewCount,
                        reviewRating: favorite.reviewRating,
                        reviewsPerRating: favorite.reviewsPerRating,
                        thumbnailUrl: favorite.thumbnailUrl,
                        openingHours: favorite.openingHours,
                        priceRange: favorite.priceRange,
                        timezone: favorite.timezone,
                        link: favorite.link,
                        popularTimes: favorite.popularTimes,
                        distanceMeters: favorite.distanceMeters
                    ),
                    about: favorite.about,
                    completeAddress: favorite.completeAddress,
                    owners: favorite.owners,
                    categories: favorite.categories,
                    images: favorite.images,
                    links: favorite.links,
                    reviews: favorite.reviews
                )
            })
        } catch {
            print("Error fetching favorites in explore page: \(error)")
        }
    }
}
