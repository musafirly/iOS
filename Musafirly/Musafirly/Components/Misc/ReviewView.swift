//
//  ReviewView.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI

struct ReviewView: View {
    let review: Review
    
    init(_ review: Review) { self.review = review }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                ContainedAsyncImage(imageUrl: review.profilePicture, showFailedImage: false)
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("\(review.name)")
                        .font(.subheadline)
                    
                    RatingView(rating: Double(review.rating))
                }
            }
            
            Text(review.description.isEmpty ? "" : "\"\(review.description)\"")
                .font(.subheadline)
        }
    }
}

#Preview {
    ReviewView(Place.defaultPlace.reviews[0])
}
