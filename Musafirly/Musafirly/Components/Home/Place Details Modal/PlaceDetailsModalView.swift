//
//  SwiftUIView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct PlaceDetailsModalView: View {
    @Binding var showDetails: Bool
    
    @StateObject var vm: PlaceDetailsModalViewModel
    
    init(placeId: String, showDetails: Binding<Bool>) {
        _vm = StateObject(wrappedValue: .init(placeId: placeId))
        
        _showDetails = showDetails
    }

    
    var body: some View {
    
        
        VStack {
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
                            .foregroundStyle(Color(UIColor.secondarySystemBackground))
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
            
            // Main information section
            ScrollView {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    // What I want to achieve is a section of the modal only for the image with a predefined height so that it doesn't push the text down
                    // Also, the width should be relative to the width of the screen AND the container its in so that it doesn't stretch the bounds of the app.
                    
                    if let imageUrl = vm.fullPlaceDetails.summary.thumbnailUrl {
                        //                if let imageUrl = "https://badurl.png" as? String {
                        AsyncImage(url: .init(string: imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                
                            case .failure(_):
                                Image(systemName: "photo.on.rectangle.angled")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.gray)
                                
                            @unknown default:
                                alert("Error", isPresented: .constant(true), actions: {
                                    Button(action: { showDetails = false } ) {
                                        Text("Close")
                                    }
                                })
                            }
                        }
                    }
                    
                    
                    IconSection(iconSystemName: "map", labelText: vm.fullPlaceDetails.summary.name)
                        .font(.headline)
                    
                    IconSection(iconSystemName: "info", labelText: vm.fullPlaceDetails.summary.description)
                        .font(.subheadline)
                    
                    
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 24)
        .task {
            do {
                try await vm.GetPlaceDetailsFor(id: vm.placeId)
            } catch {
                print("Error getting place details for details sheet")
            }
        }
    }
}

#Preview {
    PlaceDetailsModalView(
        placeId: "a2981eeb-3679-4217-ae52-4cbb333df381",
        showDetails: .constant(true))
}
