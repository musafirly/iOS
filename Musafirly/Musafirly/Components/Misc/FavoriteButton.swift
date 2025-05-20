//
//  FavoriteButton.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI


struct FavoriteButton: View {
    @Binding var isFavorited: Bool
    let actions: () -> Void
    
    init(isFavorited: Binding<Bool>, actions: @escaping () -> Void) {
        _isFavorited = isFavorited
        self.actions = actions
    }
    
    var body: some View {
        
        Button(action: {
            actions()
        }) {
            HStack {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .foregroundStyle(Color.white)
                
                Text(isFavorited ? "Unfavorite" : "Favorite")
                    .foregroundStyle(Color.white)
            }
        }
        .tint(Color.favorite)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 20))
    }
}
