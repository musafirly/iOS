//
//  ContainedAsyncImage.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//

import SwiftUI

struct ContainedAsyncImage: View {
    let imageUrl: String
    let showFailedImage: Bool
    let randomImageWidths = [250, 150, 350]
    
    init(imageUrl: String, showFailedImage: Bool = false) {
        self.imageUrl = imageUrl
        self.showFailedImage = showFailedImage
    }
    
    var body: some View {
        Group {
            AsyncImage(url: .init(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: CGFloat(randomImageWidths.randomElement() ?? 400), height: 250)
                        .background(Color(UIColor.tertiarySystemBackground))
                case .success(let image):
                    image
                        .flexibleImage()
                        .frame(maxWidth: .infinity)
                    
                case .failure(let error):
                    var _ = print("Loading image error: \(error.localizedDescription)")
                    
                    if showFailedImage {
                        Image(systemName: "photo.on.rectangle.angled")
                            .flexibleImage()
                            .foregroundColor(.gray)
                    } else {
                        EmptyView()
                    }
                    
                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
