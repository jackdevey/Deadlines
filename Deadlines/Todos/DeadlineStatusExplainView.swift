//
//  DeadlineTodoStatusExplanationView.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import SwiftUI

struct DeadlineStatusExplainView: View {
    var body: some View {
        List {
            Section {
                Text("A deadline's status represents how complete a deadline is, taking into account how much time is left to complete it.")
                    .foregroundColor(.secondary)
                    .font(.headline)
                Text("Deadlines can fall in to 1 of the 5 categories below")
                    .foregroundColor(.secondary)
            }
            Section {
                // Submitted
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "paperplane.circle")
                            .imageScale(.large)
                            .foregroundColor(.systemBlue)
                        Text("Submitted")
                    }
                    Text("Work has been submitted")
                        .foregroundColor(.secondary)
                }
                // Complete
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "checkmark.circle")
                            .imageScale(.large)
                            .foregroundColor(.systemGreen)
                        Text("Completed")
                    }
                    Text("All required work is completed")
                        .foregroundColor(.secondary)
                }
                // Progressing
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "bolt.circle")
                            .imageScale(.large)
                            .foregroundColor(.systemPurple)
                        Text("Progressing")
                    }
                    Text("Work is happening at a suitable pace")
                        .foregroundColor(.secondary)
                }
                // Warning
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                            .imageScale(.large)
                            .foregroundColor(.systemYellow)
                        Text("Stale")
                    }
                    Text("No progress made in a few days")
                        .foregroundColor(.secondary)
                }
                // Past due
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "calendar.circle")
                            .imageScale(.large)
                            .foregroundColor(.systemRed)
                        Text("Past due")
                    }
                    Text("Due date has passed")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Status explained")
    }
}
