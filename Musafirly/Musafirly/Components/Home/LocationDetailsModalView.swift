//
//  SwiftUIView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct LocationDetailsModalView: View {
    @Binding var location: Location
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
    LocationDetailsModalView(location: .constant(Location(name: "Test Name", latitude: "0", longitude: "0", address: "Test Address")), showDetails: .constant(true))
}
