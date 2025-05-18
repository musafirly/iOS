//
//  CarouselSection.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct CarouselSectionView<Content>: View where Content : View {
    private let places: [Place]
    private let titleText: String
    
    private var content: Content? = nil
    private var extraTextLabels: [String]? = nil
    
    init(
        places: [Place],
        titleText: String,
    ) where Content == EmptyView {
        self.places = places
        self.titleText = titleText
    }
    
    /// Creates a CarouselSection with custom Views in each card.
    init(
        places: [Place],
        titleText: String,
        @ViewBuilder extraCardView: () -> Content
    ) {
        self.places = places
        self.titleText = titleText
        self.content = extraCardView()
    }
    
    
    /// Creates a CarouselSection with custom Text Views below the standard card text.
    init(
        placesWithExtraLabels: [(Place, String)],
        titleText: String
    ) where Content == EmptyView {
        self.places = placesWithExtraLabels.map( { e in e.0 } )
        self.titleText = titleText
        
        self.extraTextLabels = placesWithExtraLabels.map( { e in e.1 } )
    }
    
    
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                
                Text(titleText)
                    .font(.title)
                    .bold()
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(Array(places.enumerated()), id: \.offset) { index, place in
                            CarouselPlaceCard(
                                place: place,
                                imageHeight: geometry.size.height * 0.2
                            ) {
                                if let extraCustomView = content {
                                    extraCustomView
                                } else if let label = extraTextLabels?[index] {
                                    // Note: This was made smaller just for Favorited date
                                    Text(label)
                                        .font(.footnote)
                                        .fontWeight(.light)
                                }
                            }
                            .frame(
                                width: geometry.size.width * 0.5,
                                height: geometry.size.height * 0.4)
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
