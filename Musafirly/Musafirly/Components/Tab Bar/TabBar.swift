//
//  TabBar.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//


import SwiftUI


struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    private let tabs: [Tab] = [.home, .explore]
    
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            // Background with blur
            Color.clear
                .background(.ultraThickMaterial)
            
            
            // Tab items
            HStack {
                ForEach(tabs) { tab in
                    ZStack {
                        // Indicator
                        TabBarIndicator()
                            .opacity(tab == selectedTab ? 1 : 0)
                        
                        CustomTabItem(tab: tab, isSelected: tab == selectedTab)
                            .onTapGesture {
                                selectedTab = tab
                            }
                    }
                    .animation(
                        .spring(
                            response: 0.3,
                            dampingFraction: 0.7),
                        value: selectedTab)
                }
            }
            .padding(.horizontal, 60)
            .padding(.vertical, 5)
        }
        .frame(height: 60)
    }
}

struct CustomTabBar_Preview: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
