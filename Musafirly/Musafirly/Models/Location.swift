//
//  Location.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    
    let name: String
    let coords: CLLocationCoordinate2D
    let address: String
}

extension Location {
    static let mockLocations: [Location] = [
        Location(name: "53rd & 6th Halal", coords: .init(latitude: 40.761833, longitude: -73.97903), address: "w53rd Street & 6th Ave., New York City"),
        Location(name: "ABA Turkish Restaurant", coords: .init(latitude: 40.767334, longitude: -73.98405), address: "325 W 57th St Between 8th and 9th Ave, New York City"),
        Location(name: "Au Za'Atar - East Village", coords: .init(latitude: 40.72897, longitude: -73.981186), address: "188 Avenue A, New York City"),
        Location(name: "Ariana Afghan Kabab Restaurant", coords: .init(latitude: 40.765022, longitude: -73.987816), address: "787 9th Ave, New York City"),
        Location(name: "Turkish Kitchen", coords: .init(latitude: 40.741894, longitude: -73.98136), address: "386 3rd Ave, New York City")
    ]
}


extension CLLocationCoordinate2D {
    static let newYork: Self = .init(
        latitude: Location.mockLocations.first?.coords.latitude ?? 0,
        longitude: Location.mockLocations.first?.coords.longitude ?? 0
    )
}
