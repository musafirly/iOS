//
//  SettingsView.swift
//  Musafirly
//
//  Created by Anthony on 5/19/25.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("theme") var selectedTheme: Theme = .system

    var body: some View {
        Form {
            Section("Appearance") {
                Picker(selection: $selectedTheme, label: EmptyView()) {
                    ForEach(Theme.allCases) { theme in
                        Text(theme.rawValue)
                            .tag(theme)
                    }
                }
                .pickerStyle(.inline)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
