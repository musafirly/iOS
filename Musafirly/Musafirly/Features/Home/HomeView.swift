//
//  HomeView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI


struct HomeView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    
    var body: some View {
        
        HomeMap(viewmodel: vm)
        
    }
}

#Preview {
    HomeView(vm: .init())
}
