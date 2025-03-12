//
//  TabBar.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
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


struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    private let tabs: [Tab] = [.home, .explore, .profile]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background with blur
            Color.clear
                .background(.ultraThickMaterial)
                .ignoresSafeArea()
            
            
            // Tab items
            HStack(spacing: 0) {
                ForEach(tabs) { tab in
                    
                    CustomTabItem(
                        tab: tab,
                        isSelected: selectedTab == tab
                    )
                    .onTapGesture {
                        selectedTab = tab
                    }
                    .animation( .spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
                }
            }
            .padding(.horizontal, 60)
            .padding(.vertical, 12)
            
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
                .animation(.spring(response: 0.4, dampingFraction: 0.7), value: selectedTab)
        }
        .frame(height: 30)
    }
}

struct CustomTabBar_Preview: PreviewProvider {
    static var previews: some View {
//        Spacer()
        
        CustomTabBar(selectedTab: .constant(.home))
    }
}
