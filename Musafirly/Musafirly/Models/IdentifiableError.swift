//
//  IdentifiableError.swift
//  Musafirly
//
//  Created by Anthony on 5/8/25.
//

import Foundation


struct IdentifiableError: Identifiable {
    let id = UUID() // Unique ID for alert presentation
    let error: Error // The underlying error
    var localizedDescription: String {
        // Access the error's localized description for display
        error.localizedDescription
    }
}
