//
//  ExploreViewModel.swift
//  Musafirly
//
//  Created by Anthony on 5/6/25.
//

import SwiftUI
import SwiftData

class ExploreViewModel: ObservableObject {
    @Published var favoritedPlaces: [Place] = []
    
    init() {
        fetchFavoritedPlaces()
    }
    
    func fetchFavoritedPlaces() {
        let queriedPlaces = Query(
            sort: \FavoritePlace.favoriteDate,
            order: .forward).wrappedValue
        
//        self.favoritedPlaces = queriedPlaces.map({ favorite in
//            
//        })
    }
}
