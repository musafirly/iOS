//
//  ContentView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                if selectedTab != .home {
                    HeaderView(selectedTab: $selectedTab)
                        .animation(.none, value: selectedTab)
                        .padding(.bottom, 15)
                }
                
                switch selectedTab {
                case .home:
                    HomeView()
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
