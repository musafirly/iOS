//
//  CarouselPlaceCard.swift
//  Musafirly
//
//  Created by Anthony on 5/13/25.
//

import SwiftUI

struct CarouselPlaceCard<Content>: View where Content : View {
    let place: Place
    let imageHeight: CGFloat
    
    let content: Content?
    
    init(
        place: Place,
        imageHeight: CGFloat
    ) where Content == EmptyView {
        self.place = place
        self.imageHeight = imageHeight
        self.content = nil
    }
    
    /// Creates a card with extra Views below the normal text.
    init(
        place: Place,
        imageHeight: CGFloat,
        @ViewBuilder extraCardView: () -> Content
    ) {
        self.place = place
        self.imageHeight = imageHeight
        
        self.content = extraCardView()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = place.summary.thumbnailUrl {
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
                
                Text(place.summary.name)
                    .font(.headline)
                
                Text(place.categories.first ?? "Restaurant")
                    .font(.subheadline)
                
                Spacer()
                
                content
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
    CarouselPlaceCard(place: Place.defaultPlace, imageHeight: 150)
}
