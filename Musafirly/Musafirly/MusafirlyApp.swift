//
//  MusafirlyApp.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import UIKit
import SwiftData


@main
struct MusafirlyApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var locationManager: LocationManager = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(locationManager)
        }
        .modelContainer(for: BookmarkedPlace.self, isAutosaveEnabled: true)
    }
}
