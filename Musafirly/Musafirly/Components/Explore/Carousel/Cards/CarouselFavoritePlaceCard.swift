//
//  CarouselFavoritePlaceCard.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI


struct CarouselFavoritePlaceCard: View {
    let place: FavoritePlace
    let imageHeight: CGFloat
    
    init(
        favorite: FavoritePlace,
        imageHeight: CGFloat
    ) {
        self.place = favorite
        self.imageHeight = imageHeight
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = place.thumbnailUrl {
                Group {
                    AsyncImage(url: .init(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .flexibleImage(imageHeight)
                            
                        case .failure(_):
                            Image(systemName: "photo.on.rectangle.angled")
                                .flexibleImage(imageHeight)
                                .foregroundColor(.gray)
                            
                        @unknown default:
                            var _ = print("Unknown Error in CarouselPlaceCard")
                            EmptyView()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: imageHeight)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(place.name)
                    .font(.headline)
                
                Text(place.categories.first ?? "Restaurant")
                    .font(.subheadline)
                
                Spacer()
                
                Text("Favorited on \(place.favoriteDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.footnote)
                    .fontWeight(.light)
            }
            .padding(8)
            .lineLimit(1)
            
            Spacer()
        }
        .background(Color(UIColor.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 5,
            x: 0,
            y: 5)
    }
}

#Preview {
    CarouselFavoritePlaceCard(favorite: FavoritePlace(Place.defaultPlace), imageHeight: 150)
}
