//
//  SearchNearbyLocationButton.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI


struct SearchNearbyLocationButton: View {
    @ObservedObject var vm: HomeViewModel
    
    init(_ viewmodel: HomeViewModel) {
        self.vm = viewmodel
    }
    
    var body: some View {
        Button(action: {
            Task {
                do {
                    try await vm.FindNearbyRestaurants()
                    
                    vm.mapError = nil
                } catch {
                    print("Could not find nearby restaurants using button: \(error)")
                    vm.mapError = IdentifiableError(error: error)
                }
            }
        }) {
            Image(systemName: "magnifyingglass")
        }
        .frame(width: 42, height: 42)
        .background(Color.mapButton)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .padding(6)
        .disabled(vm.loadingNewPlaces)
    }
}

