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
    @Published var fullPlaceDetails: Place
    
    init(placeId: String) {
        fullPlaceDetails = Place.defaultPlace
        
        GetPlaceDetailsFor(id: placeId)
    }
    
    
    func GetPlaceDetailsFor(id: String) {
        
        let endpointUrl: URL = .init(string: "https://api.musafirly.com/places/\(id)")!
        
        let task = URLSession.shared.dataTask(with: endpointUrl) { data, response, error in
            
            if let error {
                return print("Error fetching place details for id: \(id) - \(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return print("Error fetching place details for id: \(id) - HTTP status code: \(String(describing: response))")
            }
            
            guard data != nil else {
                return print("No Data Received")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let fetchedData = try decoder.decode(Place.self, from: mapResponse(response: (data!, response!) ))
                
                print("Place Details fetched successfully for id: \(id): \(fetchedData)")
                
                DispatchQueue.main.async {
                    self.fullPlaceDetails = fetchedData
                }
            } catch {
                print("Error decoding data for id: \(id) - \(error)")
            }
        }
        
        task.resume()
    }
}
