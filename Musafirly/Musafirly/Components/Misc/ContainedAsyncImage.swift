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
    let imageHeight: CGFloat
    
    init(imageUrl: String, showFailedImage: Bool = false, imageHeight: CGFloat = 250) {
        self.imageUrl = imageUrl
        self.showFailedImage = showFailedImage
        self.imageHeight = imageHeight
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
                        .flexibleImage(imageHeight)
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
