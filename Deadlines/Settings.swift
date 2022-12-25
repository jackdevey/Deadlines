//
//  Settings.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        List {

            Text("App theme")
            Text("App icon")
            Text("App icon")
            Text("App icon")
            Text("App icon")
            
            Section {
                Link(destination: URL(string: "https://github.com/jackdevey/Deadlines")!) {
                    Label("Contribute on GitHub", systemImage: "link")
                }
                Link(destination: URL(string: "https://github.com/jackdevey/Deadlines/issues")!) {
                    Label("Support", systemImage: "questionmark.circle")
                }
                Link(destination: URL(string: "https://github.com/jackdevey/Deadlines")!) {
                    Label("Privacy Policy", systemImage: "doc.text")
                }
            } header: {
                Text("About Deadlines")
            } footer: {
                Text("Deadlines v1.1.0")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}
