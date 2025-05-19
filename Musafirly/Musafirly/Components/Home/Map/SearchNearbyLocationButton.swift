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
            HStack{
                
                Image(systemName: "magnifyingglass")
                Text("Scan nearby")
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
        }
        .frame(height: 42)
        .background(Color.mapButton)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .padding(.horizontal, 6)
        .padding(.vertical, 10)
        .disabled(vm.loadingNewPlaces)
    }
}

