//
//  HeaderView.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(selectedTab.title)
                .font(.largeTitle)
                .bold()
            
            Spacer()
        }
    }
}

#Preview {
    HeaderView(selectedTab: .constant(.home))
}
