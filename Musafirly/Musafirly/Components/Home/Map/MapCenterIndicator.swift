//
//  MapCenterIndicator.swift
//  Musafirly
//
//  Created by Anthony on 5/8/25.
//

import SwiftUI

struct MapCenterIndicator: View {
    let loading: Bool
    
    var body: some View {
        
        Section {
            
            Circle()
                .fill(Color.centerIndicatorOuter)
                .frame(width: 16, height: 16)
            
            Circle()
                .fill(loading ? Color.centerIndicatorInnerLoading : Color.centerIndicatorInner)
                .frame(width: 10, height: 10)
                .scaleEffect(loading ? 1.2 : 1)
        }
        .shadow(radius: 4)
        .scaleEffect(loading ? 1.2 : 1)
        .animation(
            .spring(response: 0.4, dampingFraction: 0.6),
            value: loading)
    }
}


#Preview {
    MapCenterIndicator(loading: false)
}
