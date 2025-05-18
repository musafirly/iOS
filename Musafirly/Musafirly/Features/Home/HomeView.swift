//
//  HomeView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject private var vm: HomeViewModel
    @EnvironmentObject private var locationManager: LocationManager
    
    init(_ viewmodel: HomeViewModel) {
        _vm = ObservedObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        
        Group {
            if locationManager.authorizationStatus == .authorizedWhenInUse ||
               locationManager.authorizationStatus == .authorizedAlways {

                HomeMap(vm)
                    .task {
                        if let coordinate = locationManager.lastKnownLocation {
                            
                            
                            vm.mapPos = .camera(
                                .init(centerCoordinate: coordinate, distance: 1500))

                            guard vm.markerPlaces.count == 0 else { return }
                            
                            do {
                                try await vm.FindNearbyRestaurants()
                                
                                vm.mapError = nil
                                
                                print("Nearby restaurant fetching success.")
                            } catch {
                                print("Failed to find nearby restaurants in HomeView authorized task: \(error)")
                                
                                vm.mapError = IdentifiableError(error: error)
                            }
                        }
                    }
            } else if locationManager.authorizationStatus == .notDetermined {
                EmptyView()
                    .onAppear {
                        print("Requesting location authorization")
                        
                        locationManager.checkLocationAuthorization()
                    }
            } else {
                VStack(alignment: .center) {
                    Spacer()
                    
                    Text("Location access is required to show nearby places.")
                        .padding()
                    
                    Button("Open Settings") {
                        // Guide user to app settings to enable location access
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }
                    
                    Spacer()
                }
                .containerRelativeFrame(.horizontal, alignment: .top)
            }
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
    }
}

#Preview {
    HomeView(.init())
        .environmentObject(LocationManager())
}
