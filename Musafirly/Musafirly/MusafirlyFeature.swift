//
//  MusafirlyFeature.swift
//  Musafirly
//
//  Created by Anthony on 2/22/25.
//

import ComposableArchitecture

@Reducer
struct MusafirlyFeature {
    @ObservableState
    struct State {
        var selectedTab: Int = 0
    }
    
    enum Action {
       case tabButtonTapped(Int)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .tabButtonTapped(let index):
                state.selectedTab = index
                return .none
            }
            
        }
    }
}
