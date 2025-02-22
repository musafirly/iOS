//
//  MusafirlyFeature.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct MusafirlyFeature {
    @ObservableState
    struct State {
        var selectedTab: Tab = .home
    }
    
    enum Action {
       case tabButtonTapped(Tab)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .tabButtonTapped(let tab):
                state.selectedTab = tab
                return .none
            }
            
        }
    }
}
