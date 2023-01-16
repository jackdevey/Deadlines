//
//  Settings.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI
import UserNotifications

struct Settings: View {
        
    @StateObject var iconsManager: IconsManager = IconsManager()
    
    var body: some View {
        List {

            Text("Sorry, much much better features are coming soon! Deadlines will get better.")
            
            Section {
                // Change app icon
                NavigationLink(destination: IconsListView()
                    .environmentObject(iconsManager)
                ) {
                    Label("App icons", systemImage: "app")
                }
                // Privacy section
                NavigationLink(destination: PrivacyView()
                    .environmentObject(iconsManager)
                ) {
                    NiceIconLabel(text: "Privacy & Security", color: .systemIndigo, iconName: "lock")
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
