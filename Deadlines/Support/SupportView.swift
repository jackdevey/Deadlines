//
//  SupportView.swift
//  Deadlines
//
//  Created by Jack Devey on 03/01/2023.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        List {
            NavigationLink(destination: SupportStatusView()) {
                Label("Status Explained", systemImage: "questionmark.circle")
                .foregroundColor(.secondaryLabel)
            }
        }
        .navigationTitle("Support")
        .navigationBarTitleDisplayMode(.large)
    }
}
