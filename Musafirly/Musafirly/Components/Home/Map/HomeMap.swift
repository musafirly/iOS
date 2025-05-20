//
//  HomeMap.swift
//  Musafirly
//
//  Created by Anthony on 4/2/25.
//

import SwiftUI
import MapKit

struct HomeMap: View {
    @ObservedObject var vm: HomeViewModel
    
    init(_ viewmodel: HomeViewModel) {
        _vm = ObservedObject(wrappedValue: viewmodel)
    }

    
    var body: some View {
        
        Map(position: $vm.mapPos) {
            
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
        .mapControls {
            MapCompass()
            MapScaleView()
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
                    placeId: place.id,
                    showDetails: $vm.showDetailsModal,
                    showFullDetails: $vm.showFullDetails
                )
                .presentationDetents([
                    .fraction(0.99),
                    .fraction(0.55),
                ],
                    selection: .constant(.fraction(0.55))
                )
                .presentationCornerRadius(30)
            }
        }
        .overlay() {
            MapCenterIndicator(loading: vm.loadingNewPlaces)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    if !vm.holdingScreen {
                        vm.holdingScreen = true
                    }
                })
                .onEnded({ _ in vm.holdingScreen = false })
        )
        .navigationDestination(isPresented: $vm.showFullDetails) {
            if let selectedPlace = vm.selectedPlace {
                FullPlaceDetails(placeId: selectedPlace.placeId)
            }
        }
    }
}


#Preview {
    HomeMap(.init())
}
