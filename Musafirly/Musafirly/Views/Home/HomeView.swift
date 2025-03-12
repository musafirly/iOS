//
//  HomeView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import MapKit

struct AnnotationShapeStyle: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        if environment.colorScheme == .light {
            return Color.red
        } else {
            return Color.orange
        }
    }
}

struct HomeView: View {
    let locations: [Location] = Location.mockLocations
    
    @State private var showDetails = false
    @State private var currentLocation: Location = Location.mockLocations.first ?? Location(name: "Test name", latitude: "0", longitude: "0", address: "1346 67th Street")
    
    var body: some View {
        GeometryReader { geometry in
            Map {
                UserAnnotation()
                
                ForEach(locations) { loc in
                    if let latitude = Double(loc.latitude),
                       let longitude = Double(loc.longitude)
                    {
                        
                        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        
                        Annotation(
                            loc.name,
                            coordinate: coordinate
                        ) {
                            Image(systemName: "fork.knife.circle")
                                .foregroundStyle(.orange)
                                .onTapGesture {
                                    showDetails = true
                                    currentLocation = loc
                                }
                                .scaleEffect(2)
                        }
                    }
                }
            }
            .sheet(isPresented: $showDetails) {
                LocationDetailsModalView(location: $currentLocation, showDetails: $showDetails)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    HomeView()
}
