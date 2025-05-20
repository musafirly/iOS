//
//  RatingView.swift
//  Musafirly
//
//  Created by Anthony on 4/8/25.
//

import SwiftUI

struct RatingView: View {
    
    let rating: Double
    let ratingsCount: Int?
    
    
    init(rating: Double) {
        self.rating = rating
        self.ratingsCount = nil
    }
    
    init(rating: Double, ratingsCount: Int) {
        self.rating = rating
        self.ratingsCount = ratingsCount
    }
    
    
    var body: some View {
        
        HStack(spacing: 2) {
            
            ForEach((0...4).self, id: \.self) { index in
                let starName = index < Int(ceil(rating)) ? "star.fill" : "star"
                
                Image(systemName: starName)
                    .frame(
                        width: 1 * 14
                    )
                    .scaleEffect(0.75)
            }
            
            if let count = ratingsCount {
                Text("\(count)")
                    .padding(.leading, 4)
            }
        }
    }
}
