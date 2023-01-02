//
//  DeadlineTodoStatusExplanationView.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import SwiftUI

struct DeadlineStatusExplainView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("A deadline's status represents how complete a deadline is, taking into account how much time is left to complete it.")
                    .foregroundColor(.secondary)
                    .font(.headline)
                Spacer()
                Text("Deadlines can fall in to 1 of the 5 categories below")
                    .foregroundColor(.secondary)
                VStack {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                            .imageScale(.large)
                            .foregroundColor(.systemYellow)
                        Text("Partial")
                    }
                    Text("Low risk")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Status explained")
    }
}
