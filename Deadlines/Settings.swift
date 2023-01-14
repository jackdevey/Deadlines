//
//  Settings.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI
import UserNotifications

struct Settings: View {
    
    @AppStorage("useBiometrics") private var useBiometrics = false
    
    @StateObject var iconsManager: IconsManager = IconsManager()
    
    var body: some View {
        List {

            Text("Sorry, much much better features are coming soon! Deadlines will get better.")
            
            Section {
                // Biometric unlock toggle
                Toggle(isOn: $useBiometrics) {
                    Label("Biometric Unlock", systemImage: "lock.open")
                }
                // Change app icon
                NavigationLink(destination: IconsListView()
                    .environmentObject(iconsManager)
                    .navigationBarTitleDisplayMode(.inline)
                ) {
                    Label("App icons", systemImage: "app")
                }
            }
            
            
            Section {
                Link(destination: URL(string: "https://github.com/jackdevey/Deadlines")!) {
                    Label("Contribute on GitHub", systemImage: "link")
                }
                NavigationLink(destination: SupportView()) {
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
        .navigationBarTitleDisplayMode(.large)
    }
        
}
