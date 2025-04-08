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
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: isSelected ? "\(tab.icon).fill" : tab.icon)
                .font(.system(size: 20))
            Text(tab.title)
                .font(.caption)
        }
        .foregroundStyle(isSelected ? Color.white : Color.gray.opacity(0.7))
        .frame(maxWidth: .infinity)
    }
}
