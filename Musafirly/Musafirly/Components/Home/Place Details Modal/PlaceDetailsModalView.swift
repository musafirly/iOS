//
//  SwiftUIView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct PlaceDetailsModalView: View {
    @Binding var showDetails: Bool
    
    var vm: PlaceDetailsModalViewModel
    
    init(placeId: String, showDetails: Binding<Bool>) {
        self.vm = .init(placeId: placeId)
        
        _showDetails = showDetails
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            let precomputedWidth = geometry.size.width
            
            VStack(alignment: .listRowSeparatorLeading) {
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text(vm.fullPlaceDetails.summary.name)
                            .font(.title3)
                        
                        // Stars
                        RatingView(
                            rating: vm.fullPlaceDetails.summary.reviewRating,
                            ratingsCount: vm.fullPlaceDetails.summary.reviewCount)
                    }
                    
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
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    // What I want to achieve is a section of the modal only for the image with a predefined height so that it doesn't push the text down
                    // Also, the width should be relative to the width of the screen AND the container its in so that it doesn't stretch the bounds of the app.
                    Section {
                        
                        if let imageUrl = vm.fullPlaceDetails.summary.thumbnailUrl {
                            
                            AsyncImage(url: .init(string: imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(minWidth: precomputedWidth, maxWidth: precomputedWidth)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .scaledToFit()
                                case .failure(_):
                                    
                                }
                                
                            }
                            .border(.red, width: 2)
                        }
                    }
                    .imageScale(.small)
                    
                    
                    
                    Text(vm.fullPlaceDetails.completeAddress?["street"] ?? "No Address")
                        .font(.headline)
                    
                    Text(vm.fullPlaceDetails.summary.description ?? "No Description")
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
            .border(.green, width: 2)
        }
    }
}

#Preview {
    PlaceDetailsModalView(
        placeId: "a2981eeb-3679-4217-ae52-4cbb333df381",
        showDetails: .constant(true))
}
