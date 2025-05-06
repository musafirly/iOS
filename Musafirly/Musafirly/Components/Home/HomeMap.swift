//
//  HomeMap.swift
//  Musafirly
//
//  Created by Anthony on 4/2/25.
//

import SwiftUI
import MapKit

struct HomeMap: View {
    @State private var showDetails: Bool = false
    
    init(viewmodel: HomeViewModel) {
        _vm = StateObject(wrappedValue: viewmodel)
    }
    
    @StateObject var vm: HomeViewModel
    
    var markerGradient: LinearGradient = .init(
        stops: [
            .init(color: .red, location: 0),
            .init(color: .black, location: 2)],
        startPoint: .top,
        endPoint: .bottom)
    
    var body: some View {
        
        Map(initialPosition: vm.mapPos) {
            UserAnnotation()
                .mapOverlayLevel(level: .aboveLabels)
            
            ForEach(vm.markerPlaces) { place in
                
                Annotation(
                    place.name,
                    coordinate: .init(
                        latitude: place.latitude,
                        longitude: place.longitude)
                ) {
                    ZStack {
                        
                        Circle()
                            .foregroundStyle(markerGradient)
                            .frame(width: 35, height: 35)
                        
                        Image(systemName: "fork.knife")
                    }
                    .onTapGesture {
                        showDetails = true
                        vm.currentPlace = place
                    }
                }
            }
        }
        .mapControls() {
            MapUserLocationButton()
            MapCompass()
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .onMapCameraChange(frequency: .continuous) { context in
            vm.mapPos = .camera(context.camera)
        }
        .sheet(isPresented: $showDetails) {
            
            PlaceDetailsModalView(
                placeId: vm.currentPlace.id!,
                showDetails: $showDetails)
            .presentationDetents([
                .fraction(0.99),
                .fraction(0.45),
                ],
                 selection: .constant(.fraction(0.99)))
            .presentationCornerRadius(30)
        }
    }
}


#Preview {
    HomeMap(viewmodel: .init())
}
