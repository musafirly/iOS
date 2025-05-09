//
//  RatingView.swift
//  Musafirly
//
//  Created by Anthony on 4/8/25.
//

import SwiftUI

struct RatingView: View {
    
    let rating: Double
    let ratingsCount: Int
    
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
            
            Text("\(ratingsCount)")
                .padding(.leading, 4)
        }
    }
}
