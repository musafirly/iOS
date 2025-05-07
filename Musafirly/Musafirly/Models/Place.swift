//
//  Location.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import Foundation

struct PlaceSummary: Identifiable, Decodable {
    var id: String?
    
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
        case description
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
        

        // Decode the PlaceSummary properties from the *same* top-level container
        // Note: Assuming the top-level 'id' is also intended to be the summary's 'id'
        let summaryID = try container.decode(String.self, forKey: .id) // Using the top-level ID for summary ID
        let name = try container.decode(String.self, forKey: .name)
        let description = try container.decodeIfPresent(String.self, forKey: .description)
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


        // Create the PlaceSummary instance using the decoded properties
        self.summary = PlaceSummary(
            id: summaryID,
            name: name,
            description: ((description?.isEmpty) != nil) ? nil : description,
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
    
    init (summary: PlaceSummary, owners: [Owner] = [], categories: [String] = [], images: [[String: String]] = [], links: [[String: String]] = [], reviews: [Review] = []) {
        self.id = summary.id ?? "0"
        self.about = ""
        self.completeAddress = [:]
        self.summary = summary
        self.owners = owners
        self.images = images
        self.categories = categories
        self.links = links
        self.reviews = reviews
    }
}
