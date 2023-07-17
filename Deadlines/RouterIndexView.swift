//
//  RouterIndexView.swift
//  Deadlines
//
//  Created by Jack Devey on 17/07/2023.
//

import SwiftUI
import SwiftData

struct RouterIndexView: View {
    
    /// Get model context from environment
    @Environment(\.modelContext) private var context
    
    /// Whole app Navigation path
    @State var path: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            DeadlinesListView()
                .navigationDestination(for: AppRouter.self) { router in
                    switch router {
                    /// If deadline details was requested
                    case .details(let deadline):
                        DeadlineView(deadline: deadline)
                    /// If deadline checklist was requested
                    case .checklist(let deadline):
                        DeadlineTodoView(deadline: deadline)
                    /// If unknown location was requested
                    default:
                        Text("Unknown Location")
                    }
                }
        }
        .userActivity("uk.jw3.Deadlines.handoff.app", isActive: true) { activity in
            activity.isEligibleForSearch = true
            activity.isEligibleForHandoff = true
            activity.becomeCurrent()
        }
        .onContinueUserActivity("uk.jw3.Deadlines.handoff.app") { _ in
            
        }
        .onContinueUserActivity("uk.jw3.Deadlines.handoff.checklist") { activity in
            
            let handoff = try? activity.typedPayload(DeadlineHandoff.self)
            
            if let id = handoff?.id {
                /// Get deadline from data
                var deadlines = FetchDescriptor<Deadline>(
                    predicate: #Predicate { $0.id == id }
                )
                deadlines.fetchLimit = 1
                deadlines.includePendingChanges = true
                /// Fetch
                let results = try! context.fetch(deadlines)
                let deadline = results[0]
                
                path.append(AppRouter.details(deadline))
                path.append(AppRouter.checklist(deadline))
            }
        }
    }
    
}
