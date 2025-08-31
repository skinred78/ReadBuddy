//
//  SettingsView.swift
//  ReadBuddy
//
//  Created by Sam Kinred on 2025/08/31.
//


import SwiftUI

struct SettingsView: View {
    @ObservedObject var model: AppModel

    var body: some View {
        Form {
            Section("Speech") {
                HStack {
                    Text("Rate")
                    Slider(value: Binding(get: { Double(model.speechRate) },
                                          set: { model.speechRate = Float($0) }),
                           in: 0.35...0.6)
                }
                HStack {
                    Text("Pitch")
                    Slider(value: Binding(get: { Double(model.speechPitch) },
                                          set: { model.speechPitch = Float($0) }),
                           in: 0.8...1.2)
                }
            }
            Section("Display") {
                Toggle("Large Text", isOn: $model.largeText)
            }
        }
        .padding()
    }
}
