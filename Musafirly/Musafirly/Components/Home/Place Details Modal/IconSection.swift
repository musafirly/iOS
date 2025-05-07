//
//  IconSection.swift
//  Musafirly
//
//  Created by Anthony on 5/6/25.
//

import SwiftUI


struct IconSection: View {
    let iconSystemName: String
    let labelText: String
    
    var body: some View {
        
        HStack {
            Image(systemName: iconSystemName)
                .frame(width: 16, height: 16)
            Text(labelText)
        }
        .padding(.horizontal, 2)
    }
}
