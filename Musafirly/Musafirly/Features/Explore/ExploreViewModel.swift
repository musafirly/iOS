//
//  ExploreViewModel.swift
//  Musafirly
//
//  Created by Anthony on 5/6/25.
//

import SwiftUI
import SwiftData

class ExploreViewModel: ObservableObject {
    @Published var bookmarkedPlaces: [BookmarkedPlace] = []
    
    init() {
        fetchBookmarkedPlaces()
    }
    
    func fetchBookmarkedPlaces() {
        self.bookmarkedPlaces = Query(
            sort: \BookmarkedPlace.bookmarkDate,
            order: .forward).wrappedValue
    }
}
