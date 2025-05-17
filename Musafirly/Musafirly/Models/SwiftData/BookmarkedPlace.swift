//
//  BookmarkedPlaces.swift
//  Musafirly
//
//  Created by Anthony on 5/13/25.
//

import SwiftUI
import SwiftData


@Model
class BookmarkedPlace {
    @Attribute(.unique)
    var bookmarkId: String
    
    
    var name: String
    var placeDescription: String?
    var latitude: Double
    var longitude: Double
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
    
    var about: String?
    var completeAddress: [String: String]?
    var owners: [Owner]
//    var emails: [[String: String]]
    var images: [[String: String]]
    var categories: [String]
    var links: [[String: String]]
    var reviews: [Review]
    
    var bookmarkDate: Date
    
    init(_ place: Place) {
        self.bookmarkDate = .now
        
        self.name = place.summary.name
        self.bookmarkId = place.summary.placeId
        self.placeDescription = place.summary.placeDescription
        self.latitude = place.summary.latitude
        self.longitude = place.summary.longitude
        self.phone = place.summary.phone
        self.website = place.summary.website
        self.reviewCount = place.summary.reviewCount
        self.reviewRating = place.summary.reviewRating
        self.reviewsPerRating = place.summary.reviewsPerRating
        self.thumbnailUrl = place.summary.thumbnailUrl
        self.openingHours = place.summary.openingHours
        self.priceRange = place.summary.priceRange
        self.timezone = place.summary.timezone
        self.link = place.summary.link
        self.popularTimes = place.summary.popularTimes
        self.distanceMeters = place.summary.distanceMeters
        
        self.about = place.about
        self.completeAddress = place.completeAddress
        self.owners = place.owners
        self.images = place.images
        self.categories = place.categories
        self.links = place.links
        self.reviews = place.reviews
    }
    
    static func searchForPlacePredicate(
        withPlaceId: String
    ) -> Predicate<BookmarkedPlace> {
        return #Predicate<BookmarkedPlace> { model in
            model.bookmarkId == withPlaceId
        }
    }
}
