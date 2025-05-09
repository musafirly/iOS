//
//  MarkerView.swift
//  Musafirly
//
//  Created by Anthony on 5/8/25.
//

import SwiftUI


struct MarkerView: View {
    var markerGradient: LinearGradient = .init(
        stops: [
            .init(color: .red, location: 0),
            .init(color: .black, location: 2)],
        startPoint: .top,
        endPoint: .bottom)
    
    var body: some View {
        ZStack {
            
            Circle()
                .foregroundStyle(markerGradient)
                .frame(width: 35, height: 35)
            
            Image(systemName: "fork.knife")
        }
    }
}
