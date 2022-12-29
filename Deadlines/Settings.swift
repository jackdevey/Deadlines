//
//  Settings.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("useBiometrics") private var useBiometrics = false
    
    var body: some View {
        List {

            Text("Sorry, much much better features are coming soon! Deadlines will get better.")
            
            Section {
                Toggle("Require Biometrics", isOn: $useBiometrics)
            }
            
            Section {
                Link(destination: URL(string: "https://github.com/jackdevey/Deadlines")!) {
                    Label("Contribute on GitHub", systemImage: "link")
                }
                Link(destination: URL(string: "https://github.com/jackdevey/Deadlines/issues")!) {
                    Label("Support", systemImage: "questionmark.circle")
                }
                Link(destination: URL(string: "https://deadlines.jw3.uk/privacy")!) {
                    Label("Privacy Policy", systemImage: "doc.text")
                }
            } header: {
                Text("About Deadlines")
            } footer: {
                Text("Deadlines v\(Bundle.main.appVersionShort)")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}
