//
//  LocationExtension.swift
//  Musafirly
//
//  Created by Anthony on 4/7/25.
//


extension PlaceSummary {
    static let mockPlaces: [PlaceSummary] = [
        PlaceSummary(id: "0", name: "53rd & 6th Halal", latitude: 40.761833, longitude: -73.97903),
        PlaceSummary(id: "1", name: "ABA Turkish Restaurant", latitude: 40.767334, longitude: -73.98405),
        PlaceSummary(id: "2", name: "Au Za'Atar - East Village", latitude: 40.72897, longitude: -73.981186),
        PlaceSummary(id: "3", name: "Ariana Afghan Kabab Restaurant", latitude: 40.765022, longitude: -73.987816),
        PlaceSummary(id: "4", name: "Turkish Kitchen", latitude: 40.741894, longitude: -73.98136)
    ]
}


extension PlaceSummary {
    static let newYork: Self = .init(
        id: "0",
        name: "New York",
        latitude: 40.7678,
        longitude: -73.9645,
        phone: "+1 (917) 555-1212",
        reviewRating: 3.5,
        thumbnailUrl: "https://media.istockphoto.com/id/1454217037/photo/statue-of-liberty-and-new-york-city-skyline-with-manhattan-financial-district-world-trade.jpg?s=612x612&w=0&k=20&c=6V54_qVlDfo59GLEdY2W8DOjLbbHTJ9y4AnJ58a3cis=",
    )
    
    static let ZSOffices: Self = .init(
        id: "0",
        name: "ZS Offices",
        latitude: 39.9527597,
        longitude: -75.1681796,
        phone: "+1 (917) 555-1212",
        reviewRating: 5,
        thumbnailUrl: "https://offices.net/officeimages/12369_1.jpg"
    )
    
    static let defaultPlaceSummary: Self = .init(
        id: "420dfbe3-ba2a-42da-8ca5-b70af0e665a2",
        name: "Example Restaurant",
        latitude: 0,
        longitude: 0,
        thumbnailUrl: "https://lh3.googleusercontent.com/gps-cs-s/AC9h4nrPXeWiDg_skeGJpM1WK4XiU-LdIR-MRTGSk0FBSpvBPrCgWlItNZV5uvBAFoBdMHFqiIZteWv2aC-iFyqqDkpQUjQdMWzRYT4pSx_E60_ziUDbGtAVeM-LL2uZeCom4H0TcmQQdQ=w408-h240-k-no-pi0-ya249-ro-0-fo100"
    )
}

extension Place {
    static let defaultPlace: Self = .init(
        summary: PlaceSummary.defaultPlaceSummary,
        owners: [])
    
    static let mockPlaces: [Place] = [
        Place(summary: .newYork),
        Place(summary: .ZSOffices)
    ]
    
    init(from: FavoritePlace) {
        self = Place(
            summary: PlaceSummary(
                id: from.favoriteId,
                name: from.name,
                placeDescription: from.placeDescription,
                latitude: from.latitude,
                longitude: from.longitude,
                phone: from.phone,
                website: from.website,
                reviewCount: from.reviewCount,
                reviewRating: from.reviewRating,
                reviewsPerRating: from.reviewsPerRating,
                thumbnailUrl: from.thumbnailUrl,
                openingHours: from.openingHours,
                priceRange: from.priceRange,
                timezone: from.timezone,
                link: from.link,
                popularTimes: from.popularTimes,
                distanceMeters: from.distanceMeters
            ),
            about: from.about,
            completeAddress: from.completeAddress,
            owners: from.owners,
            categories: from.categories,
            images: from.images,
            links: from.links,
            reviews: from.reviews
        )
    }
}
