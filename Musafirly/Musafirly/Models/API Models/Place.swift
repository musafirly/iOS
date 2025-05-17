//
//  Location.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import Foundation

struct PlaceSummary: Identifiable, Codable {
    var id: String { placeId }
    
    var placeId: String
    
    let name: String
    var placeDescription: String?
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
    
    enum CodingKeys: String, CodingKey {
        case placeId = "id"
        case name
        case placeDescription = "description"
        case latitude
        case longitude
        case phone
        case website
        case reviewCount
        case reviewRating
        case reviewsPerRating
        case thumbnailUrl
        case openingHours
        case priceRange
        case timezone
        case link
        case popularTimes
        case distanceMeters
    }
    
    init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)

         self.placeId = try container.decode(String.self, forKey: .placeId)
         self.name = try container.decode(String.self, forKey: .name)
         self.placeDescription = try container.decodeIfPresent(String.self, forKey: .placeDescription)
         self.latitude = try container.decode(Double.self, forKey: .latitude)
         self.longitude = try container.decode(Double.self, forKey: .longitude)
         self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
         self.website = try container.decodeIfPresent(String.self, forKey: .website)
         self.reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount) ?? 0
         self.reviewRating = try container.decodeIfPresent(Double.self, forKey: .reviewRating) ?? 0.0
         self.reviewsPerRating = try container.decodeIfPresent([Int: Double].self, forKey: .reviewsPerRating)
         self.thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
         self.openingHours = try container.decodeIfPresent([String: [String]].self, forKey: .openingHours)
         self.priceRange = try container.decodeIfPresent(String.self, forKey: .priceRange)
         self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
         self.link = try container.decodeIfPresent(String.self, forKey: .link)
         self.popularTimes = try container.decodeIfPresent([String: [String: Int]].self, forKey: .popularTimes)
         self.distanceMeters = try container.decodeIfPresent(Double.self, forKey: .distanceMeters)
     }


    init(
        id: String,
        name: String,
        placeDescription: String? = nil,
        latitude: Double,
        longitude: Double,
        phone: String? = nil,
        website: String? = nil,
        reviewCount: Int = 0,
        reviewRating: Double = 0.0,
        reviewsPerRating: [Int: Double]? = nil,
        thumbnailUrl: String? = nil,
        openingHours: [String: [String]]? = nil,
        priceRange: String? = nil,
        timezone: String? = nil,
        link: String? = nil,
        popularTimes: [String: [String: Int]]? = nil,
        distanceMeters: Double? = nil
    ) {
        self.placeId = id
        self.name = name
        self.placeDescription = placeDescription
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.website = website
        self.reviewCount = reviewCount
        self.reviewRating = reviewRating
        self.reviewsPerRating = reviewsPerRating
        self.thumbnailUrl = thumbnailUrl
        self.openingHours = openingHours
        self.priceRange = priceRange
        self.timezone = timezone
        self.link = link
        self.popularTimes = popularTimes
        self.distanceMeters = distanceMeters
    }
}


struct Place: Identifiable, Codable {
    var id: String
    
    let summary: PlaceSummary
    let about: String?
    let completeAddress: [String: String]?
    let owners: [Owner]
//    let emails: [[String: String]]
    let images: [[String: String]]
    let categories: [String]
    let links: [[String: String]]
    let reviews: [Review]
    
    
    
    // This includes the keys that belong to PlaceSummary.
    enum CodingKeys: String, CodingKey {
        case id
        case about
        case completeAddress
        case owners
        // I don't know what this looks like yet
//        case emails
        case images
        case categories
        case links
        case reviews

        // Keys belonging to PlaceSummary, but are flattened in the JSON response from GetPlaceByID
        case name
        case placeDescription = "description"
        case latitude
        case longitude
        case phone
        case website
        case reviewCount
        case reviewRating
        case reviewsPerRating
        case thumbnailUrl
        case openingHours
        case priceRange
        case timezone
        case link
        case popularTimes
        case distanceMeters
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        
        self.id = try container.decode(String.self, forKey: .id)
        self.about = try container.decodeIfPresent(String.self, forKey: .about)
        // Only grabbing the first element in the complete_address array as our address dictionary.
        self.completeAddress = try container.decodeIfPresent([[String: String]].self, forKey: .completeAddress)?.first
        self.owners = try container.decodeIfPresent([Owner].self, forKey: .owners) ?? []
//        self.emails = try container.decodeIfPresent([[String: String]].self, forKey: .emails)
        self.images = try container.decodeIfPresent([[String: String]].self, forKey: .images) ?? []
        self.categories = try container.decodeIfPresent([[String: String]].self, forKey: .categories)?.compactMap(
            // Flatten dicts of id and name to just name.
            { $0.count > 0 ? $0["name"] : nil }
        ) ?? []
        self.links = try container.decodeIfPresent([[String: String]].self, forKey: .links) ?? []
        self.reviews = try container.decodeIfPresent([Review].self, forKey: .reviews) ?? []
        

        let name = try container.decode(String.self, forKey: .name)
        let description = try container.decodeIfPresent(String.self, forKey: .placeDescription)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        let phone = try container.decodeIfPresent(String.self, forKey: .phone)
        let website = try container.decodeIfPresent(String.self, forKey: .website)
        let reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount) ?? 0
        let reviewRating = try container.decodeIfPresent(Double.self, forKey: .reviewRating) ?? 0.0
        let reviewsPerRating = try container.decodeIfPresent([Int: Double].self, forKey: .reviewsPerRating)
        let thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        let openingHours = try container.decodeIfPresent([String: [String]].self, forKey: .openingHours)
        let priceRange = try container.decodeIfPresent(String.self, forKey: .priceRange)
        let timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        let link = try container.decodeIfPresent(String.self, forKey: .link)
        let popularTimes = try container.decodeIfPresent([String: [String: Int]].self, forKey: .popularTimes)
        let distanceMeters = try container.decodeIfPresent(Double.self, forKey: .distanceMeters)


        self.summary = PlaceSummary(
            id: id,
            name: name,
            placeDescription: (description == nil || description!.isEmpty) ? nil : description,
            latitude: latitude,
            longitude: longitude,
            phone: phone,
            website: website,
            reviewCount: reviewCount,
            reviewRating: reviewRating,
            reviewsPerRating: reviewsPerRating,
            thumbnailUrl: thumbnailUrl,
            openingHours: openingHours,
            priceRange: priceRange,
            timezone: timezone,
            link: link,
            popularTimes: popularTimes,
            distanceMeters: distanceMeters
        )
    }
    
    init(
        summary: PlaceSummary,
        about: String? = nil,
        completeAddress: [String: String]? = [:],
        owners: [Owner] = [],
        categories: [String] = [],
        images: [[String: String]] = [],
        links: [[String: String]] = [],
        reviews: [Review] = []
    ) {
        self.id = summary.id
        self.about = about
        self.completeAddress = completeAddress
        self.summary = summary
        self.owners = owners
        self.images = images
        self.categories = categories
        self.links = links
        self.reviews = reviews
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(summary.id, forKey: .id)
        try container.encode(summary.name, forKey: .name)
        try container.encodeIfPresent(summary.placeDescription, forKey: .placeDescription)
        try container.encode(summary.latitude, forKey: .latitude)
        try container.encode(summary.longitude, forKey: .longitude)
        try container.encode(summary.phone, forKey: .phone)
        try container.encodeIfPresent(summary.website, forKey: .website)
        try container.encode(summary.reviewCount, forKey: .reviewCount)
        try container.encode(summary.reviewRating, forKey: .reviewRating)
        try container.encodeIfPresent(summary.reviewsPerRating, forKey: .reviewsPerRating)
        try container.encodeIfPresent(summary.thumbnailUrl, forKey: .thumbnailUrl)
        try container.encodeIfPresent(summary.openingHours, forKey: .openingHours)
        try container.encodeIfPresent(summary.priceRange, forKey: .priceRange)
        try container.encodeIfPresent(summary.timezone, forKey: .timezone)
        try container.encodeIfPresent(summary.link, forKey: .link)
        try container.encodeIfPresent(summary.popularTimes, forKey: .popularTimes)
        try container.encodeIfPresent(summary.distanceMeters, forKey: .distanceMeters)
    }
}
