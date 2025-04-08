//
//  SwiftUIView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct PlaceDetailsModalView: View {
    var place: Place
    @Binding var showDetails: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Button(action: { showDetails.toggle() }) {
                    ZStack {
                        Circle()
                            .foregroundStyle(Color(UIColor.tertiarySystemBackground))
                            .opacity(0.9)
                        
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.primary)
                    }
                }
                .frame(
                    width: 32,
                    height: 32
                )
            }
            .padding(.horizontal, 16)
            
            GeometryReader { geometry in
                
            VStack(alignment: .leading) {
                
                Text(place.name)
                    .font(.largeTitle)
                
                AsyncImage(url: .init(string: place.thumbnailURL ?? ""))
                    
               
                
                
                Text(place.address ?? "No Address")
            }
            }
        }
    }
}

#Preview {
    PlaceDetailsModalView(
        place: .newYork,
        showDetails: .constant(true))
}
