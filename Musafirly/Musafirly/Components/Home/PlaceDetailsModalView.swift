//
//  SwiftUIView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct PlaceDetailsModalView: View {
    var place: PlaceSummary
    @Binding var showDetails: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            let precomputedWidth = geometry.size.width
            
            VStack(alignment: .listRowSeparatorLeading) {
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text(place.name)
                            .font(.title3)
                        
                        // Stars
                        RatingView(
                            rating: place.reviewRating,
                            ratingsCount: place.reviewCount)
                    }
                    
                    Spacer()
                    
                    Button(action: { showDetails.toggle() }) {
                        ZStack {
                            Circle()
                                .foregroundStyle(Color(UIColor.tertiarySystemBackground))
                                .opacity(0.9)
                            
                            Image(systemName: "xmark")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .frame(
                        width: 32,
                        height: 32
                    )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    // What I want to achieve is a section of the modal only for the image with a predefined height so that it doesn't push the text down
                    // Also, the width should be relative to the width of the screen AND the container its in so that it doesn't stretch the bounds of the app.
                    Section {
                        
                        AsyncImage(
                            url: .init(string: place.thumbnailUrl ?? .fallbackImageUrl)
                        ) { image in
                            image
                                .resizable()
                                .frame(maxWidth: precomputedWidth)
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .border(.red, width: 2)
                    }
                    .imageScale(.medium)
                    
                    
                    
                    Text("No Address")
                        .font(.headline)
                    
                    Text(place.description ?? "No Description")
                        .font(.headline)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
            .border(.green, width: 2)
        }
    }
}

#Preview {
    PlaceDetailsModalView(
        place: .newYork,
        showDetails: .constant(true))
}
