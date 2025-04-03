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
        self.vm = viewmodel
    }
    
    var vm: HomeViewModel
    
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
            
            ForEach(vm.locations) { loc in
                
                Annotation(
                    loc.name,
                    coordinate: loc.coords
                ) {
                    ZStack {
                        
                        Circle()
                            .foregroundStyle(markerGradient)
                            .frame(width: 35, height: 35)
                        
                        Image(systemName: "fork.knife")
                    }
                    .onTapGesture {
                        showDetails = true
                        vm.currentLocation = loc
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
            
            LocationDetailsModalView(
                location: vm.currentLocation,
                showDetails: $showDetails)
            .presentationDetents([
                .fraction(0.99),
                .fraction(0.2),
                .fraction(0.45),
                ],
                 selection: .constant(.fraction(0.45)))
        }
    }
}


#Preview {
    HomeMap(viewmodel: .init())
}
