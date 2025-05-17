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
    
    var homeView = HomeView()
    
    var yes = print(URL.applicationSupportDirectory.path(percentEncoded: false))
    
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
                }
                
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(LocationManager())
}
