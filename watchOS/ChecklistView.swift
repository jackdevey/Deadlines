//
//  ChecklistView.swift
//  Deadlines
//
//  Created by Jack Devey on 17/07/2023.
//

import SwiftUI
import WatchKit

struct ChecklistView: View {
    
    /// Deadline ref from caller
    @StateObject var deadline: Deadline
    
    var body: some View {
        VStack {
            /// If Deadline has checklist
            if !(deadline.todos?.isEmpty ?? false) {
                List {
                    ForEach(deadline.todos!) { todo in
                        Button {
                            todo.done.toggle()
                        } label: {
                            Label(todo.name, systemImage: todo.done ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(todo.done ? .green : .primary)
                        }
                    }
                }
                /// Otherwise show error
            } else {
                Label("Create a Checklist Item on another device", systemImage: "macbook.and.iphone")
            }
        }
        .navigationTitle("Checklist")
        .userActivity("uk.jw3.Deadlines.handoff.checklist", isActive: true) { activity in
            try? activity.setTypedPayload(DeadlineHandoff(id: deadline.id))
            activity.isEligibleForSearch = true
            activity.isEligibleForHandoff = true
            activity.becomeCurrent()
        }
    }
}
