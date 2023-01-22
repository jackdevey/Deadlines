//
//  Settings.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
        
    @StateObject var iconsManager: IconsManager = IconsManager()
    
    var body: some View {
        List {
            
            Section {
                // App Icons section
                NavigationLink(destination: IconsListView().environmentObject(iconsManager)) {
                    NiceIconLabel(text: "App Icons", color: .systemGreen, iconName: "app.badge.checkmark.fill")
                }
                // Privacy section
                NavigationLink(destination: PrivacyView()) {
                    NiceIconLabel(text: "Privacy & Security", color: .systemIndigo, iconName: "lock.fill")
                }
            }
            
            Section {
                // Contribute link
                Link(destination: URL(string: "https://github.com/jackdevey/Deadlines")!) {
                    NiceIconLabel(text: "Contribute on GitHub", color: .systemTeal, iconName: "link")
                }
                .tint(.primary)
                // Tip jar section
                NavigationLink(destination: TipJarView()) {
                    NiceIconLabel(text: "Tip Jar", color: .systemBlue, iconName: "hand.thumbsup.fill")
                }
                // Licenses section
                NavigationLink(destination: CreditsView()) {
                    NiceIconLabel(text: "Acknowledgements", color: .magenta, iconName: "heart.fill")
                }
                // Support section
                NavigationLink(destination: SupportView()) {
                    NiceIconLabel(text: "Support", color: .systemPink, iconName: "questionmark.app.fill")
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
