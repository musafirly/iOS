//
//  LocationExtension.swift
//  Musafirly
//
//  Created by Anthony on 4/7/25.
//


extension PlaceSummary {
    static let mockPlaces: [PlaceSummary] = [
        PlaceSummary(name: "53rd & 6th Halal", latitude: 40.761833, longitude: -73.97903),
        PlaceSummary(name: "ABA Turkish Restaurant", latitude: 40.767334, longitude: -73.98405),
        PlaceSummary(name: "Au Za'Atar - East Village", latitude: 40.72897, longitude: -73.981186),
        PlaceSummary(name: "Ariana Afghan Kabab Restaurant", latitude: 40.765022, longitude: -73.987816),
        PlaceSummary(name: "Turkish Kitchen", latitude: 40.741894, longitude: -73.98136)
    ]
}


extension PlaceSummary {
    static let newYork: Self = .init(
        name: "New York",
        latitude: PlaceSummary.mockPlaces.first?.latitude ?? 40.7678,
        longitude: PlaceSummary.mockPlaces.first?.longitude ?? 73.9645,
        phone: "+1 (917) 555-1212",
        reviewRating: 3.5,
        thumbnailUrl: "https://media.istockphoto.com/id/1454217037/photo/statue-of-liberty-and-new-york-city-skyline-with-manhattan-financial-district-world-trade.jpg?s=612x612&w=0&k=20&c=6V54_qVlDfo59GLEdY2W8DOjLbbHTJ9y4AnJ58a3cis=",
    )
    
    static let ZSOffices: Self = .init(
        name: "ZS Offices",
        latitude: 39.9527597,
        longitude: -75.1681796,
        phone: "+1 (917) 555-1212",
        reviewRating: 5,
        thumbnailUrl: "https://offices.net/officeimages/12369_1.jpg"
    )
    
    static let defaultPlaceSummary: Self = .init(
        name: "No Name",
        latitude: 0,
        longitude: 0)
}

extension Place {
    static let defaultPlace: Self = .init(
        summary: PlaceSummary.defaultPlaceSummary,
        owners: [])
}
