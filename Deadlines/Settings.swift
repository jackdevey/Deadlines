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
    
    var body: some View {
        List {

            Text("Sorry, much much better features are coming soon! Deadlines will get better.")
            
            Section {
                // Biometric unlock toggle
                Toggle(isOn: $useBiometrics) {
                    Label("Biometric Unlock", systemImage: "lock.open")
                }
                NavigationLink {
                    NotificationsView()
                } label: {
                    HStack {
                        Label("Notifications", systemImage: "bell")
                        Text("BETA")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Button("Aside icon") {
                UIApplication.shared.setAlternateIconName("IconAside")
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
    
    
    struct NotificationsView: View {
        
        @AppStorage("allowNotifications") private var allowNotifications: Bool = false
        
        private var notificationsManager: NotificationsManager = NotificationsManager()
        
        var body: some View {
            Form {
                Toggle("Allow notifications", isOn: $allowNotifications)
                // When the toggle changes
                    .onChange(of: allowNotifications) { _ in
                        // Request permissions for notifications
                        notificationsManager.askForPermission(rejected: {
                            // Set the notifications to off
                            allowNotifications = false
                        })
                    }
                Section {
                    
                }
            }
            // Notifications title
                .navigationTitle("Notifications")
        }
        
    }
    
}
