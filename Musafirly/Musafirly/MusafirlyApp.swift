//
//  MusafirlyApp.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

@main
struct MusafirlyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
