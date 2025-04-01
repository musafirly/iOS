//
//  HomeViewModel.swift
//  Musafirly
//
//  Created by Anthony on 3/12/25.
//

import Foundation
import SwiftUI
import MapKit


class HomeViewModel: ObservableObject {
    @Published var mapPos: MapCameraPosition = .camera(.init(
        centerCoordinate: .newYork,
        distance: 1500))
}
