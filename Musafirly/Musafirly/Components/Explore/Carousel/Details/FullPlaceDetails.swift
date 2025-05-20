//
//  CarouselFavoritePlaceDetails.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI
import SwiftData


struct FullPlaceDetails: View {
    @StateObject private var vm: FullPlaceDetailsViewModel
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    init(placeId: String) {
        _vm = StateObject(wrappedValue: FullPlaceDetailsViewModel(placeId: placeId))
    }
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                // Images
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        
                        if let thumbnailUrl = vm.place.summary.thumbnailUrl {
                            ContainedAsyncImage(imageUrl: thumbnailUrl)
                                .rounded(5)
                        }
                        
                        ForEach(vm.place.images.indices, id: \.self) { index in
                            if let imageUrl = vm.place.images[index]["url"] {
                                ContainedAsyncImage(imageUrl: imageUrl, showFailedImage: false)
                                    .rounded(5)
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    
                    // Description
                    if let description = vm.place.summary.placeDescription {
                        
                        IconSection(
                            iconSystemName: "info",
                            labelText: description)
                        .font(.headline)
                    }
                    
                    
                    // Category
                    HStack {
                        if let category = vm.place.categories.first {
                            
                            IconSection(
                                iconSystemName: "tag",
                                labelText: category)
                            .font(.subheadline)
                        }
                        
                        RatingView(
                            rating: vm.place.summary.reviewRating,
                            ratingsCount: vm.place.summary.reviewCount)
                    }
                    
                    
                    // Address
                    if let addressParts = vm.place.completeAddress,
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
                    
                    
                    if let phone = vm.place.summary.phone {
                        IconSection(iconSystemName: "phone", labelText: phone)
                    }
                    
                    
                    // Website
                    if let website = vm.place.summary.website,
                       let url = URL(string: String(website.trimmingPrefix("/url?q=")))?.host() {
                        IconSection(
                            iconSystemName: "text.page",
                            labelText: url
                        )
                        .font(.subheadline)
                    }
                    
                    
                    // Favorite Button
                    FavoriteButton(isFavorited: $vm.isFavorited) {
                        if vm.isFavorited {
                            vm.removeFavorite(modelContext)
                        } else {
                            vm.saveFavorite(modelContext)
                        }
                    }
                    
                    Divider()
                    
                    // Reviews
                    if vm.place.summary.reviewCount > 0 {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recent \(min(vm.place.summary.reviewCount, 10)) Reviews")
                                .font(.title3)
                            
                            VStack(alignment: .leading, spacing: 20) {
                                ForEach(vm.place.reviews) { review in
                                    ReviewView(review)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .task {
            do {
                try vm.fetchIfPlaceFavorited(modelContext)
            } catch {
                print("Error fetching place favorited status: \(error)")
            }
            
            guard !vm.isFavorited else { return }
            
            do {
                try await vm.fetchPlaceDetails()
            } catch {
                print("Error fetching full place details for details screen")
            }
        }
    }
}
