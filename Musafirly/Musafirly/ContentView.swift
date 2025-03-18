//
//  ContentView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import CoreData
import MapKit

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    var homeView = HomeView(vm: .init())
    
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                if selectedTab != .home {
                    HeaderView(selectedTab: $selectedTab)
                        .animation(.none, value: selectedTab)
                        .padding(.bottom, 8)
                }
                
                switch selectedTab {
                case .home:
                    homeView
                case .explore:
                    ExploreView()
                case .profile:
                    ProfileView()
                }
                
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
