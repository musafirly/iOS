//
//  ExploreView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct ExploreView: View {
    let mockLocations: [Location] = Location.mockLocations

    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            CarouselSectionView(
                locations: mockLocations,
                titleText: "Popular Near You")
            
            CarouselSectionView(
                locations: mockLocations,
                titleText: "Your Favorites")
            
            Spacer()
            
        }
    }
}

#Preview {
    ExploreView()
}
