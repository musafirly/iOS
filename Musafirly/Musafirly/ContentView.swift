//
//  ContentView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    //    @AppStorage("theme") private var theme: ColorScheme = .light
    
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var exploreViewModel = ExploreViewModel()
    
    var body: some View {
        
        VStack (alignment: .leading) {
            switch selectedTab {
            case .home:
                HomeView(homeViewModel)
            case .explore:
                ExploreView(exploreViewModel)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(LocationManager())
}
