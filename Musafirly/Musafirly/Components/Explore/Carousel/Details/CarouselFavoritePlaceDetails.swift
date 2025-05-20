//
//  CarouselFavoritePlaceDetails.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI
import SwiftData


struct CarouselFavoritePlaceDetails: View {
    @State private var showError: Bool = false
    @State private var isFavorited: Bool = true
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    let place: FavoritePlace

    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                // Images
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        
                        if let thumbnailUrl = place.thumbnailUrl {
                            ContainedAsyncImage(imageUrl: thumbnailUrl)
                                .rounded(5)
                        }
                        
                        ForEach(place.images.indices, id: \.self) { index in
                            if let imageUrl = place.images[index]["url"] {
                                ContainedAsyncImage(imageUrl: imageUrl, showFailedImage: false)
                                    .rounded(5)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    
                    // Description
                    if let description = place.placeDescription {
                        
                        IconSection(
                            iconSystemName: "info",
                            labelText: description)
                        .font(.headline)
                    }
                    
                    
                    // Category
                    HStack {
                        if let category = place.categories.first {
                            
                            IconSection(
                                iconSystemName: "tag",
                                labelText: category)
                            .font(.subheadline)
                        }
                        
                        RatingView(
                            rating: place.reviewRating,
                            ratingsCount: place.reviewCount)
                    }
                    
                    
                    // Address
                    if let addressParts = place.completeAddress,
                       let street = addressParts["street"],
                       let city = addressParts["city"],
                       let state = addressParts["state"],
                       let zip = addressParts["postal_code"]
                    {
                        
                        let address = "\(street), \(city), \(state) \(zip)"
                        
                        IconSection(
                            iconSystemName: "location",
                            labelText: address)
                        .font(.subheadline)
                    }
                    
                    
                    if let phone = place.phone {
                        IconSection(iconSystemName: "phone", labelText: phone)
                    }
                    
                    
                    // Website
                    if let website = place.website,
                       let url = URL(string: String(website.trimmingPrefix("/url?q=")))?.host() {
                        IconSection(
                            iconSystemName: "text.page",
                            labelText: url
                        )
                        .font(.subheadline)
                    } else if let link = place.link,
                              let url = URL(string: link)?.host() {
                        IconSection(
                            iconSystemName: "link",
                            labelText: url
                        )
                        .font(.subheadline)
                    }
                    
                    
                    // Favorite Button
                    FavoriteButton(isFavorited: $isFavorited) {
                        if isFavorited {
                            removeFavorite()
                        } else {
                            saveFavorite()
                        }
                    }
                    
                    Divider()
                    
                    // Reviews
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recent \(min(place.reviewCount, 10)) Reviews")
                            .font(.title3)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(place.reviews) { review in
                                ReviewView(review)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}


extension CarouselFavoritePlaceDetails {
    func saveFavorite() {
        guard !isFavorited else {
            print("Place \(place.favoriteId) is marked as cached.")
            return
        }
        
        print("Caching place with id \(place.favoriteId)")
        
        modelContext.insert(place)

        isFavorited = true
    }

    
    func removeFavorite() {
         do {
             print("Attempting to delete favorite with id \(place.favoriteId)")

             try modelContext.delete(model: FavoritePlace.self, where: FavoritePlace.searchForPlacePredicate(withPlaceId: place.favoriteId))
             
             isFavorited = false
         } catch {
             print("Error deleting favorite: \(error)")
         }
     }
}
