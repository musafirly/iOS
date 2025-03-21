//
//  HomeViewModel.swift
//  Musafirly
//
//  Created by Anthony on 3/12/25.
//

import Foundation
import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let newYork: Self = .init(
        latitude: Double(Location.mockLocations.first?.latitude ?? "0")!,
        longitude: Double(Location.mockLocations.first?.longitude ?? "0")!
    )
}

class HomeViewModel: ObservableObject {
    @Published var mapPos: MapCameraPosition = .camera(.init(
        centerCoordinate: .newYork,
        distance: 1500))
}
