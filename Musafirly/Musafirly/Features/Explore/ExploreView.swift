//
//  ExploreView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import SwiftData


struct ExploreView: View {
    @ObservedObject private var vm: ExploreViewModel
    @Environment(\.modelContext) private var modelContext: ModelContext

    init(_ viewmodel: ExploreViewModel) {
        _vm = ObservedObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 20) {
                    CarouselFavoriteSection(
                        favoritePlaces: vm.favoritedPlaces,
                        titleText: "Your Favorites")
                    
                    Spacer()
            }
            .onAppear() {
                do {
                    print("Retrieving favorite restaurants for explore page...")
                    
                    try vm.fetchFavoritedPlaces(modelContext)
                } catch {
                    print("Could not get favorites: \(error)")
                }
            }
        }
        .navigationTitle("Explore")
    }
}

#Preview {
    ExploreView(.init())
}
