//
//  MusafirlyApp.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct MusafirlyApp: App {
    let persistenceController = PersistenceController.shared
    
    static let GlobalStore = Store(initialState: MusafirlyFeature.State()) {
        MusafirlyFeature()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
