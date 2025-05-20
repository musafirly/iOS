//
//  SwiftUIView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI
import SwiftData


struct PlaceDetailsModalView: View {
    @Binding var showDetails: Bool
    @Binding var showFullDetails: Bool
    
    @StateObject var vm: PlaceDetailsModalViewModel
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    
    
    init(placeId: String, showDetails: Binding<Bool>, showFullDetails: Binding<Bool>) {
        _vm = StateObject(wrappedValue: .init(placeId: placeId))
        
        _showDetails = showDetails
        _showFullDetails = showFullDetails
    }

    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    
                    Text(vm.fullPlaceDetails.summary.name)
                        .font(.title3)
                    
                    // Stars
                    HStack {
                        
                        Text(vm.fullPlaceDetails.categories.first ?? "Restaurant")
                        
                        RatingView(
                            rating: vm.fullPlaceDetails.summary.reviewRating,
                            ratingsCount: vm.fullPlaceDetails.summary.reviewCount)
                    }
                }
                .lineLimit(1)
                
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
            .padding(.horizontal)
            
            if vm.isLoading {
                ProgressView("Fetching details...")
                    .padding()
                Spacer()
            } else {
                
                // Main information section
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // What I want to achieve is a section of the modal only for the image with a predefined height so that it doesn't push the text down
                        // Also, the width should be relative to the width of the screen AND the container its in so that it doesn't stretch the bounds of the app.
                        
                        if let imageUrl = vm.fullPlaceDetails.summary.thumbnailUrl {
                            ContainedAsyncImage(imageUrl: imageUrl)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            
                            if let halalScore = vm.fullPlaceDetails.summary.halalScore,
                                halalScore > 0.7 {
                                
                                HalalBadge()
                                    .frame(width: 150)
                            }
                            
                            
                            // Description
                            if let description = vm.fullPlaceDetails.summary.placeDescription {
                                
                                IconSection(
                                    iconSystemName: "info",
                                    labelText: description)
                                .font(.subheadline)
                            }
                            
                            // Website
                            if let website = vm.fullPlaceDetails.summary.website,
                               let url = URL(string: String(website.trimmingPrefix("/url?q=")))?.host() {
                                IconSection(
                                    iconSystemName: "text.page",
                                    labelText: url
                                )
                                .font(.subheadline)
                            }
                            
                            
                            // Favorite Button
                            FavoriteButton(isFavorited: $vm.isCached) {
                                if vm.isCached {
                                    vm.removeFavorite(modelContext)
                                } else {
                                    vm.saveFavorite(modelContext)
                                }
                            }
                            
                            Divider()
                            
                            Button(action: {
                                print("Clicked show more details")
                                
                                showFullDetails = true
                                
                                dismiss()
                            }) {
                                HStack {
                                    Image(systemName: "chevron.right")
                                    
                                    Text("Show More Details")
                                }
                                .foregroundStyle(Color.primary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.vertical, 24)
        .task(id: vm.placeId) {
            
            do {
                try vm.tryLoadCachedPlaceDetails(modelContext)
            } catch {
                print("Error loading cached place details for details sheet: \(error)")
            }
            
            guard !vm.isCached else {
                print("Place found in cache or already loaded from previous state.")
                vm.isLoading = false
                
                return
            }
            
            
            do {
                print("Place not cached/loaded, fetching from API.")
                
                try await vm.fetchPlaceDetails()
            } catch {
                print("Error getting place details for details sheet: \(error)")
            }
            
            vm.isLoading = false
        }
    }
}

#Preview {
    PlaceDetailsModalView(
        placeId: "a2981eeb-3679-4217-ae52-4cbb333df381",
        showDetails: .constant(true),
        showFullDetails: .constant(false)
    )
}
