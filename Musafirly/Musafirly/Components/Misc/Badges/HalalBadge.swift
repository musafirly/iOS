//
//  HalalBadge.swift
//  Musafirly
//
//  Created by Anthony on 5/20/25.
//

import SwiftUI

struct HalalBadge: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.halalBadge)
            
            HStack {
                Image(systemName: "checkmark.seal")
                Text("Likely Halal")
            }
            .frame(height: 32)
        }
    }
}

#Preview {
    HalalBadge()
}
