//
//  ContentView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var selectedTab = MusafirlyApp.GlobalStore.selectedTab
    
    var body: some View {
        ZStack {
            VStack {
                    
                Text("Testing Test")
                
                Spacer()
                    
                CustomTabBar()
            }
        }
    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
