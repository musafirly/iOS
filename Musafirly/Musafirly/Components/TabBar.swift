//
//  TabBar.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//


import SwiftUI
import ComposableArchitecture

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


struct CustomTabBar: View {
    let store = MusafirlyApp.GlobalStore
    let tabs: [Tab] = [.home, .discover, .profile]
    
    var body: some View {
        ZStack(alignment: .top) {
        // Background with blur
            Color.clear
                .background(.ultraThickMaterial)
                .ignoresSafeArea()
        
            
            // Tab items
            HStack(spacing: 0) {
                ForEach(tabs.indices, id: \.self) { index in
                    CustomTabItem(
                        tab: tabs[index],
                        isSelected: store.selectedTab == index
                    )
                    .onTapGesture {
                        store.send(.tabButtonTapped(index), animation: .spring(response: 0.3, dampingFraction: 0.7))
                    }
                }
            }
            .padding(.horizontal, 60)
            .padding(.vertical, 12)
        
            
            if let selectedTab = Tab(rawValue: store.selectedTab) {
                // Indicator
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 24, height: 4)
                    .cornerRadius(2)
                    .offset(
                        x: CGFloat(selectedTab.rawValue - 1) * (UIScreen.main.bounds.width - 120) / 3,
                        y: -2
                    )
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
                
                // Blur for a subtle glow effect
                Circle()
                    .fill(Color.accentColor.opacity(0.4))
                    .frame(width: 70, height: 70)
                    .blur(radius: 25)
                    .offset(
                        x: CGFloat(selectedTab.rawValue - 1) * (UIScreen.main.bounds.width - 120) / 3,
                        y: -2
                    )
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: store.selectedTab)
            }
        }
        .frame(height: 30)
    }
}
