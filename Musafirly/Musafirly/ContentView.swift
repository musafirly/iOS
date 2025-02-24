//
//  ContentView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import CoreData
import ComposableArchitecture

struct ContentView: View {
    
    var body: some View {
        WithViewStore(MusafirlyApp.GlobalStore, observe: \.selectedTab) { viewStore in
            ZStack {
                VStack (alignment: .leading) {
                    if viewStore.state != .home {
                        HeaderView(selectedTab: viewStore.state)
                            .animation(.none, value: viewStore.state)
                            .padding(.bottom, 15)
                    }
                    
                    switch viewStore.state {
                    case .home:
                        HomeView()
                    case .explore:
                        ExploreView()
                    case .profile:
                        ProfileView()
                    }
                    
                    Spacer()
                    
                    CustomTabBar()
                }
            }
        }
    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
