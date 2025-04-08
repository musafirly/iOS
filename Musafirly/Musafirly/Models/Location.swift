//
//  Location.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Decodable {
    var id = UUID()
    
    let name: String
    let latitude: Double
    let longitude: Double
    var address: String?
    var phone: String?
    var website: String?
    var reviewCount: Int?
    var reviewRating: Double?
    var thumbnailURL: String?
    var openingHours: [String: [String]]?
    var distanceMeters: Double?
}
