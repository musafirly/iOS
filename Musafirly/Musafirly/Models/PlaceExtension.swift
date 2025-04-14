//
//  LocationExtension.swift
//  Musafirly
//
//  Created by Anthony on 4/7/25.
//


extension Place {
    static let mockPlaces: [Place] = [
        Place(name: "53rd & 6th Halal", latitude: 40.761833, longitude: -73.97903, address: "w53rd Street & 6th Ave., New York City"),
        Place(name: "ABA Turkish Restaurant", latitude: 40.767334, longitude: -73.98405, address: "325 W 57th St Between 8th and 9th Ave, New York City"),
        Place(name: "Au Za'Atar - East Village", latitude: 40.72897, longitude: -73.981186, address: "188 Avenue A, New York City"),
        Place(name: "Ariana Afghan Kabab Restaurant", latitude: 40.765022, longitude: -73.987816, address: "787 9th Ave, New York City"),
        Place(name: "Turkish Kitchen", latitude: 40.741894, longitude: -73.98136, address: "386 3rd Ave, New York City")
    ]
}


extension Place {
    static let newYork: Self = .init(
        name: "New York",
        latitude: Place.mockPlaces.first?.latitude ?? 40.7678,
        longitude: Place.mockPlaces.first?.longitude ?? 73.9645,
        address: "New York Address",
        phone: "+1 (917) 555-1212",
        thumbnailUrl: "https://media.istockphoto.com/id/1454217037/photo/statue-of-liberty-and-new-york-city-skyline-with-manhattan-financial-district-world-trade.jpg?s=612x612&w=0&k=20&c=6V54_qVlDfo59GLEdY2W8DOjLbbHTJ9y4AnJ58a3cis=",
    )
}
