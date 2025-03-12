//
//  Location.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import Foundation

struct Location: Identifiable {
    let id = UUID()
    
    let name: String
    let latitude: String
    let longitude: String
    let address: String
}

extension Location {
    static let mockLocations: [Location] = [
        Location(name: "53rd & 6th Halal", latitude: "40.761833", longitude: "-73.97903", address: "w53rd Street & 6th Ave., New York City"),
        Location(name: "ABA Turkish Restaurant", latitude: "40.767334", longitude: "-73.98405", address: "325 W 57th St Between 8th and 9th Ave, New York City"),
        Location(name: "Au Za'Atar - East Village", latitude: "40.72897", longitude: "-73.981186", address: "188 Avenue A, New York City"),
        Location(name: "Ariana Afghan Kabab Restaurant", latitude: "40.765022", longitude: "-73.987816", address: "787 9th Ave, New York City"),
        Location(name: "Turkish Kitchen", latitude: "40.741894", longitude: "-73.98136", address: "386 3rd Ave, New York City")
    ]
}
