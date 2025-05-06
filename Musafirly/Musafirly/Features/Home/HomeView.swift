//
//  HomeView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    
    
    var body: some View {
        HomeMap(viewmodel: vm)
            .task {
                do {
                    try await vm.FindNearbyRestaurants()
                } catch {
                    print("Failed to find nearby restaurants in HomeView: \(error)")
                }
            }
    }
}

#Preview {
    HomeView(vm: .init())
}
