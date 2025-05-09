//
//  HomeMap.swift
//  Musafirly
//
//  Created by Anthony on 4/2/25.
//

import SwiftUI
import MapKit

struct HomeMap: View {
    @StateObject var vm: HomeViewModel
    
    init(viewmodel: HomeViewModel) {
        _vm = StateObject(wrappedValue: viewmodel)
    }

    
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
                    MarkerView()
                        .onTapGesture {
                            vm.showDetailsModal = true
                            vm.selectedPlace = place
                        }
                }
            }
        }
        .mapControls() {
            MapUserLocationButton()
            MapCompass()
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .onMapCameraChange(frequency: .onEnd) { context in
            vm.mapCameraDidChange(context)
        }
        .alert(item: $vm.mapError) { identifiableError in
             Alert(
                 title: Text("Error"),
                 message: Text(identifiableError.localizedDescription),
                 dismissButton: .default(Text("OK")) {
                     vm.mapError = nil
                 }
             )
         }
        .sheet(isPresented: $vm.showDetailsModal) {
            
            if let place = vm.selectedPlace {
            
                PlaceDetailsModalView(
                    placeId: place.id!,
                    showDetails: $vm.showDetailsModal)
                .presentationDetents([
                    .fraction(0.99),
                    .fraction(0.45),
                ],
                    selection: .constant(.fraction(0.45))
                )
                .presentationCornerRadius(30)
            }
        }
    }
}


#Preview {
    HomeMap(viewmodel: .init())
}
