//
//  Theme.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//


import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case system = "System Default"
    case light = "Light"
    case dark = "Dark"

    var id: String { self.rawValue }
}
