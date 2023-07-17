//
//  DeadlineView.swift
//  DeadlinesWatch Watch App
//
//  Created by Jack Devey on 16/07/2023.
//

import SwiftUI

struct DeadlineView: View {
    
    @StateObject var deadline: Deadline
    
    var body: some View {
        VStack {
            List {
                VStack(alignment: .leading) {
                    Text(deadline.progress)
                    ProgressView(value: deadline.percentCompleted, total: 1)
                    Text(deadline.progressDescription)
                        .font(.caption2)
                }
                
                Section {
                    NavigationLink {
                        ChecklistView(deadline: deadline)
                    } label: {
                        Label("Checklist", systemImage: "checklist")
                    }
                    Label("Links", systemImage: "link")
                }
            }
        }
        .navigationTitle(deadline.name)
    }
}
