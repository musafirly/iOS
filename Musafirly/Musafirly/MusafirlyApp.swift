//
//  MusafirlyApp.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import SwiftData

@main
struct MusafirlyApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var locationManager: LocationManager = .init()
    @AppStorage("theme") var userColorScheme: Theme = .system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(locationManager)
                .preferredColorScheme(getResolvedColorScheme())
        }
        .modelContainer(for: FavoritePlace.self, isAutosaveEnabled: true)
    }
    
    private func getResolvedColorScheme() -> ColorScheme? {
            switch userColorScheme {
            case .system:
                return nil // nil means follow system settings
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
}
