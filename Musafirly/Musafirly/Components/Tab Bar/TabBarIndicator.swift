//
//  TabBarIndicator.swift
//  Musafirly
//
//  Created by Anthony on 4/7/25.
//

import SwiftUI

struct TabBarIndicator: View {
    let tabIndicatorYOffset: CGFloat = -40
    
    var body: some View {
        Group {
            Rectangle()
                .fill(Color.accentColor)
                .frame(width: 24, height: 4)
                .cornerRadius(2)
                .offset(
                    x: 0,
                    y: tabIndicatorYOffset)
            
            // Blur for a subtle glow effect
            Circle()
                .fill(Color.accentColor.opacity(0.4))
                .frame(width: 70, height: 70)
                .blur(radius: 25)
        }
    }
}
