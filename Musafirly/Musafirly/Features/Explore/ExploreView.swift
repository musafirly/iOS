//
//  ExploreView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct ExploreView: View {
    let places: [Place] = Place.mockPlaces

    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            CarouselSectionView(
                places: places,
                titleText: "Popular Near You")
            
            CarouselSectionView(
                places: places,
                titleText: "Your Favorites")
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ExploreView()
}
