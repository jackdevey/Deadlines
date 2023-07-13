//
//  SettingsSheet.swift
//  Deadlines
//
//  Created by Jack Devey on 12/07/2023.
//

import SwiftUI

struct SettingsSheet: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                    // Privacy & Security
                    NavigationLink {
                        PrivacySecurityView()
                    } label: {
                        DeadlineLabel(text: "Privacy & Security", icon: "lock")
                    }
                    
                    // App Icon
                    NavigationLink {
                        AppIconsView()
                    } label: {
                        DeadlineLabel(text: "App Icon", icon: "app.badge")
                    }
                    
                } header: {
                    Text("General")
                }
                
                Section {
                    KeyValueRow {
                        DeadlineLabel(text: "Version", icon: "info.circle")
                    } value: {
                        Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("About")
                }
            }
            .navigationTitle("Settings")
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Close button
                ToolbarItem {
                    Button("Close") {
                        isShowing = false
                    }
                }
            }
        }
    }
    
}
