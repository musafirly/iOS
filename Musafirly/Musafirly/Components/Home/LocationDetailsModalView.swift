//
//  SwiftUIView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct LocationDetailsModalView: View {
    var location: Location
    @Binding var showDetails: Bool
    
    var body: some View {
        VStack{
            Button(action: { showDetails.toggle() }) {
                Image(systemName: "xmark.circle")
            }
            
            Text(location.name)
            
            Text(location.address)
        }
    }
}

#Preview {
    LocationDetailsModalView(
        location: Location(
            name: "Test Name",
            coords: .newYork,
            address: "Test Address"
        ),
        showDetails: .constant(true))
}
