//
//  Tab.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//


//
//  Tab.swift
//  Hikari
//
//  Created by L. Lawliet on 2/17/25.
//

enum Tab: Int, CaseIterable, Identifiable, Equatable {
    case home
    case explore
    case profile
    
    var id: Int { rawValue }

    var icon: String {
        switch self {
        case .home: return "house"
        case .explore: return "magnifyingglass.circle"
        case .profile: return "person.crop.circle"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .explore: return "Explore"
        case .profile: return "Profile"
        }
    }
}
