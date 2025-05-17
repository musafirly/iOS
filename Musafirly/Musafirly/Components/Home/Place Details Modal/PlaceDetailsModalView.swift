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
    
    // NOTE: Noticed an issue where the sheet will show the previous location's data before showing its own. Should reset the vm's current place to default on disappear.
    @StateObject var vm: PlaceDetailsModalViewModel
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    init(placeId: String, showDetails: Binding<Bool>) {
        _vm = StateObject(wrappedValue: .init(placeId: placeId))
        
        _showDetails = showDetails
    }
    
    private func deleteAllBookmarkedPlaces() {
        do {
            let fetchDescriptor = FetchDescriptor<FavoritePlace>()
            let bookmarkedPlaces = try modelContext.fetch(fetchDescriptor)
            print("Deleting \(bookmarkedPlaces)")
            for place in bookmarkedPlaces {
                modelContext.delete(place)
            }
            print("Successfully deleted all BookmarkedPlace records.")
        } catch {
            print("Error deleting BookmarkedPlace records: \(error)")
        }
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
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // What I want to achieve is a section of the modal only for the image with a predefined height so that it doesn't push the text down
                    // Also, the width should be relative to the width of the screen AND the container its in so that it doesn't stretch the bounds of the app.
                    
                    if let imageUrl = vm.fullPlaceDetails.summary.thumbnailUrl {
//                         if let imageUrl = "https://badurl.png" as? String {
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
                    
                    
                    // Name
                    IconSection(iconSystemName: "map", labelText: vm.fullPlaceDetails.summary.name)
                        .font(.headline)
                    
                    
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
                    } else if let link = vm.fullPlaceDetails.summary.link,
                       let url = URL(string: link)?.host() {
                         IconSection(
                             iconSystemName: "link",
                             labelText: url
                         )
                         .font(.subheadline)
                     }
                    
                    
                    // Bookmark Button
                    Button(action: {
                        // Pass the modelContext to the ViewModel's saving/deleting functions
                        if vm.isCached {
                            vm.deleteBookmark(modelContext)
                        } else {
                            vm.saveAsBookmark(modelContext)
                        }
                    } ) {
                        HStack {
                            Image(systemName: vm.isCached ? "bookmark.fill" : "bookmark")
                            Text(vm.isCached ? "Bookmarked" : "Bookmark") // Change text based on state
                        }
                    }
                    .tint(Color(UIColor.secondarySystemBackground))
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 24)
        .task {
            
//            deleteAllBookmarkedPlaces()
            
            do {
                try vm.tryLoadCachedPlaceDetails(modelContext)
            } catch {
                print("Error loading cached place details for details sheet: \(error)")
            }

            if !vm.isCached {
                print("Place not cached/loaded, fetching from API.")
                
                do {
                    try await vm.fetchPlaceDetails()
                } catch {
                    print("Error getting place details for details sheet: \(error)")
                }
            } else {
                 print("Place found in cache or already loaded from previous state.")
            }
        }
    }
}

#Preview {
    PlaceDetailsModalView(
        placeId: "a2981eeb-3679-4217-ae52-4cbb333df381",
        showDetails: .constant(true))
}
