//
//  MarkerView.swift
//  Musafirly
//
//  Created by Anthony on 5/8/25.
//

import SwiftUI


struct MarkerView: View {
    var defaultGradient: LinearGradient = .init(
        stops: [
            .init(color: .red, location: 0),
            .init(color: .black, location: 2)],
        startPoint: .top,
        endPoint: .bottom)
    
    let halalGradient: LinearGradient = .init(
        stops: [
            .init(color: Color.halalBadge, location: 0),
            .init(color: .black, location: 2)],
        startPoint: .top,
        endPoint: .bottom)
    
    let isHalal: Bool
    
    init(isHalal: Bool = false) {
        self.isHalal = isHalal
    }
    
    var body: some View {
        ZStack {
            
            Circle()
                .foregroundStyle(isHalal ? halalGradient : defaultGradient)
                .frame(width: 35, height: 35)
            
            Image(systemName: "fork.knife")
        }
    }
}
