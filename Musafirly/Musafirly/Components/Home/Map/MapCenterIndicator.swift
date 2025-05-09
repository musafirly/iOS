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
        
        Circle()
            .fill(Color.centerIndicatorOuter)
            .frame(width: 16, height: 16)
        
        Circle()
            .fill(loading ? Color.centerIndicatorInnerLoading : Color.centerIndicatorInner)
            .frame(width: 10, height: 10)
            .animation(
                .spring(
                    dampingFraction: 0.7),
                value: loading)
    }
}


#Preview {
    MapCenterIndicator(loading: false)
}
