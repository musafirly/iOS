//
//  CarouselFavoriteSection.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI

struct CarouselFavoriteSection: View {
    private let places: [FavoritePlace]
    private let titleText: String
    
    
    init(
        favoritePlaces: [FavoritePlace],
        titleText: String,
    ) {
        self.places = favoritePlaces
        self.titleText = titleText
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                
                Text(titleText)
                    .font(.title)
                    .bold()
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top, spacing: 16) {
                        ForEach(places) { place in
                            NavigationLink {
                                
                            } label: {
                                CarouselFavoritePlaceCard(
                                    favorite: place,
                                    imageHeight: geometry.size.height * 0.2
                                )
                                .frame(
                                    width: geometry.size.width * 0.5,
                                    height: geometry.size.height * 0.4)
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                    .padding(16)
                }
                .scrollIndicators(.never)
            }
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    CarouselSectionView(places: Place.mockPlaces, titleText: "Test")
}
