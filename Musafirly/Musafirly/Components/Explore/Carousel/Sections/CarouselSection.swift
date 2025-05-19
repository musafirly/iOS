//
//  CarouselSection.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct CarouselSectionView: View {
    private let places: [Place]
    private let titleText: String
    
    
    init(
        places: [Place],
        titleText: String,
    ) {
        self.places = places
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
                        ForEach(Array(places.enumerated()), id: \.offset) { index, place in
                            NavigationLink {
                                
                                
                            } label: {
                                CarouselPlaceCard(
                                    place: place,
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
//                .navigationDestination(for: String.self) { place in
//                    PlaceDetailsModalView(place: place)
//                }
            }
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    CarouselSectionView(places: Place.mockPlaces, titleText: "Test")
}
