//
//  CarouselSection.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct CarouselSectionView: View {
    let places: [Place]
    let titleText: String
    
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(titleText)
                .font(.title)
                .bold()
            
            ForEach(places) { place in
                Text(place.name)
            }
        }
    }
}

#Preview {
    CarouselSectionView(places: Place.mockPlaces, titleText: "Test")
}
