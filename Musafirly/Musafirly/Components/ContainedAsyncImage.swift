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
    
    init(imageUrl: String, showFailedImage: Bool = true) {
        self.imageUrl = imageUrl
        self.showFailedImage = showFailedImage
    }
    
    var body: some View {
        Group {
            AsyncImage(url: .init(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .flexibleImage()
                        .frame(maxWidth: .infinity)
                    
                case .failure:
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
