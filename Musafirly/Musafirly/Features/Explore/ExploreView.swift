//
//  ExploreView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI


struct ExploreView: View {
    @StateObject private var vm: ExploreViewModel

    init() {
        _vm = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            CarouselSectionView(
                places: vm.favoritedPlaces,
                titleText: "Your Favorites")
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ExploreView()
}
