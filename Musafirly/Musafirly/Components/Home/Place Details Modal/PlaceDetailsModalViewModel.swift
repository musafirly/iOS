//
//  PlaceDetailsModalViewModel.swift
//  Musafirly
//
//  Created by Anthony on 5/1/25.
//

import Foundation
import SwiftUI

class PlaceDetailsModalViewModel: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var fullPlaceDetails: Place = Place.defaultPlace
    let placeId: String
    
    var fullAddress: String?
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    
    @MainActor
    func GetPlaceDetailsFor(id: String) async throws {
        
        let endpointUrl: URL = .init(string: "https://api.musafirly.com/places/\(id)")!

        
        print("Calling Musafirly API for place id \(id)")
        
        let (data, response) = try await URLSession.shared.data(from: endpointUrl)
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            return print("Server error: \(response.debugDescription)")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let decodedPlaceDetails = try decoder.decode(Place.self, from: data)
        
        
        self.fullPlaceDetails = decodedPlaceDetails
        
        if let addressDict = fullPlaceDetails.completeAddress {
            let street = addressDict["street"]
            let city = addressDict["city"]
            let state = addressDict["state"]
            
            fullAddress = "\(street ?? ""), \(city ?? ""), \(state ?? "")"
        }
    }
}
