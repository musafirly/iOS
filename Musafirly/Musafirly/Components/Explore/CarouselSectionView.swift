//
//  CarouselSection.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct CarouselSectionView: View {
    let locations: [Location]
    let titleText: String
    
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(titleText)
                .font(.title)
                .bold()
            
            ForEach(locations) { loc in
                Text(loc.name)
            }
        }
    }
}

#Preview {
    CarouselSectionView(locations: Location.mockLocations, titleText: "Test")
}
