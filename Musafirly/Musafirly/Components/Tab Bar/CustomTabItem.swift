//
//  CustomTabItem.swift
//  Musafirly
//
//  Created by Anthony on 4/7/25.
//

import SwiftUI

struct CustomTabItem: View {
    let tab: Tab
    let isSelected: Bool
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        let selectedColor: Color = colorScheme == .dark ? .white : .black
        
        VStack(spacing: 4) {
            Image(systemName: isSelected ? "\(tab.icon).fill" : tab.icon)
                .font(.system(size: 20))
            Text(tab.title)
                .font(.caption)
        }
        .foregroundStyle(isSelected ? selectedColor : Color.gray.opacity(0.7))
        .frame(maxWidth: .infinity)
    }
}
