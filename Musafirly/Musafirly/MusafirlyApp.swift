//
//  MusafirlyApp.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import UIKit
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    GMSServices.provideAPIKey("AIzaSyDwyLzPH0PC-Sq9TJavTI5A1UJ32Knw-eo")
    return true
  }
}

@main
struct MusafirlyApp: App {
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
