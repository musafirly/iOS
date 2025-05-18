//
//  ImageViewModifier.swift
//  Musafirly
//
//  Created by Anthony on 5/18/25.
//

import SwiftUI


extension Image {
    func flexibleImage(_ imageHeight: CGFloat = 250) -> some View {
        self
            .resizable()
            .frame(height: imageHeight)
            .scaledToFit()
            .clipped()
    }
}


extension View {
    func rounded(_ cornerRadius: CGFloat = 20) -> some View {
        self
            .clipShape(RoundedRectangle(cornerSize: .init(width: cornerRadius, height: cornerRadius)))
    }
}
