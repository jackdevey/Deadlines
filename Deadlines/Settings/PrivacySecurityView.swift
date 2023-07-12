//
//  PrivacySecurityView.swift
//  Deadlines
//
//  Created by Jack Devey on 13/07/2023.
//

import SwiftUI

struct PrivacySecurityView: View {
    
    @State var useBiometrics = false
    
    var body: some View {
        List {
            
            Section {
                Text("Deadlines stores encrypted data in iCloud to enable data sharing between your Apple devices")
                    .foregroundColor(.secondary)
                    .font(.headline)
                Text("Data is encrypted with a key stored in your iCloud keychain. If you lose access to this, you will not be able to access any of your Deadlines in this app.")
                    .foregroundColor(.secondary)
            }
            
            Section(
                header: Text("App Security"),
                footer: Text("Adding an extra layer of security can help to protect your Deadlines.")
            ) {
                
                // Use Biometrics
                Toggle(isOn: $useBiometrics) {
                    DeadlineLabel(text: "Face Unlock", icon: "faceid")
                }
                
            }
            
            Section(
                header: Text("Manage your data"),
                footer: Text("You have complete control over your data. If you don't feel happy, you can delete all app data immediately, or export it for use elsewhere.")
            ) {
                
                // Export App Data
                Button {
                    
                } label: {
                    DeadlineLabel(text: "Export All Data", icon: "square.and.arrow.up")
                }
                .tint(.primary)
                
                // Delete All Data
                Button(role: .destructive) {
                    
                } label: {
                    DeadlineLabel(text: "Delete All Data", icon: "trash")
                }
            }
            
            Section {
                // Privacy Policy
                Link(destination: URL(string: "https://deadlines.jw3.uk/privacy")!) {
                    DeadlineLabel(text: "Privacy Policy", icon: "arrow.up.forward.app")
                }
            } footer: {
                Text("No personally identifiable data is ever collected by this app, only the details of your Deadlines.")
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Privacy & Security")
    }
}
