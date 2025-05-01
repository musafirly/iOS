//
//  Location.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import Foundation

struct PlaceSummary: Identifiable, Decodable {
    var id: String = UUID().uuidString
    
    let name: String
    var description: String?
    let latitude: Double
    let longitude: Double
    var phone: String?
    var website: String?
    var reviewCount: Int = 0
    var reviewRating: Double = 0
    var reviewsPerRating: [Int: Double]?
    var thumbnailUrl: String?
    var openingHours: [String: [String]]?
    var priceRange: String?
    var timezone: String?
    var link: String?
    var popularTimes: [String: [String: Int]]?
    var distanceMeters: Double?
}


struct Place: Identifiable, Decodable {
    var id: String
    
    let summary: PlaceSummary
    var about: String?
    var completeAddress: [String: String]?
    var owners: [Owner]
}


