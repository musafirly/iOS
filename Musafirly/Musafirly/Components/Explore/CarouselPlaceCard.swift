//
//  CarouselPlaceCard.swift
//  Musafirly
//
//  Created by Anthony on 5/13/25.
//

import SwiftUI

struct CarouselPlaceCard: View {
    let place: Place
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(place.summary.name)
                        .font(.title3)
                    
                    // Stars
                    HStack {
                        
                        Text(place.categories.first ?? "Restaurant")
                        
                        RatingView(
                            rating: place.summary.reviewRating,
                            ratingsCount: place.summary.reviewCount)
                    }
                }
            }
            
            // Main information section
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    if let imageUrl = place.summary.thumbnailUrl {
                        AsyncImage(url: .init(string: imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                
                            case .failure(_):
                                Image(systemName: "photo.on.rectangle.angled")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.gray)
                                
                            @unknown default:
                                var _ = print("Error loading image")
                            }
                        }
                    }
                    
                    
                    IconSection(iconSystemName: "map", labelText: place.summary.name)
                        .font(.headline)
                    
                    
                    if let description = place.summary.placeDescription {
                        
                        IconSection(
                            iconSystemName: "info",
                            labelText: description)
                        .font(.subheadline)
                    }
                    
                    if let website = place.summary.website {
                        let url = website
                            .trimmingPrefix("/url?q=")
                            .split(separator: "&")[0]
                            .split(separator: "%")[0]
                        
                        IconSection(
                            iconSystemName: "text.page",
                            labelText: String(url)
                        )
                        .font(.subheadline)

                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 24)
    }
}

#Preview {
    CarouselPlaceCard(place: Place.defaultPlace)
}
