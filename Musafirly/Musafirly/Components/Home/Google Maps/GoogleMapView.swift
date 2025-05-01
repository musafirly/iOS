//
//  MapView.swift
//  Musafirly
//
//  Created by Anthony on 3/21/25.
//

import SwiftUI
import GoogleMaps

// Source:  https://medium.com/@Rutik_Maraskolhe/understanding-google-maps-integration-in-swiftui-8b44c852f69a
struct GoogleMapView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Updated UI View")
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> some UIView {
        let mapView: GMSMapView = .init()
        
        // Map view settings
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        context.coordinator.mapView = mapView
        
        // Request location authorization
        context.coordinator.locationManager.requestWhenInUseAuthorization()
        context.coordinator.locationManager.delegate = context.coordinator
        
        let marker: GMSMarker = .init(position: .init(latitude: PlaceSummary.newYork.latitude, longitude: PlaceSummary.newYork.longitude))
        marker.map = mapView
        
        return mapView
    }
    
    
    // Coordinator to handle events
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var mapView: GMSMapView?
        var locationManager = CLLocationManager()
        
        
        // Location manager detects new locations availble
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//        {
//            guard var location = locations.first else { return }
//            print("New Location: \(location)")
//            
//            #if targetEnvironment(simulator)
//                let initialLocation = Location.mockLocations.first!
//            location = .init(latitude: initialLocation.coords.latitude, longitude: initialLocation.coords.longitude)
//            #endif
//            
//            // Set camera position to current location
//            let zoom: Float = 18.0
//            let camera = GMSCameraPosition.camera(
//                withLatitude: location.coordinate.latitude,
//                longitude: location.coordinate.longitude,
//                zoom: zoom)
//            
//            mapView?.animate(to: camera)
//        }
    
        
        // Authorization status change handler
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
        {
            if status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
                mapView?.isMyLocationEnabled = true
                mapView?.settings.myLocationButton = true
                
                // Force unwrap - could be dangerous if location manager somehow hasn't retrieved a location yet
                var location = locationManager.location!
                
                // Direct map to mock locations in simulator instead of San Francisco's Union Square
                #if targetEnvironment(simulator)
                    let initialLocation = PlaceSummary.mockPlaces.first!
                location = .init(latitude: initialLocation.latitude, longitude: initialLocation.longitude)
                #endif
                
                let camera = GMSCameraPosition.camera(
                    withLatitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude,
                    zoom: 300.0)
                
                mapView?.animate(to: camera)
            }
        }
    }
}

#Preview {
    GoogleMapView()
}
