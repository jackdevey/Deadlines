//
//  ContentView.swift
//  DeadlinesWatch Watch App
//
//  Created by Jack Devey on 16/07/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    /// Model context
    @Environment(\.modelContext) private var context
    
    /// Query to get all the deadlines sorted closest to finish first
    @Query(sort: \.due, order: .reverse) var deadlines: [Deadline]
    
    /// Manage navigation path
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack {
            VStack {
                /// Deadlines are synced from other device
                if !deadlines.isEmpty {
                    List {
                        ForEach(deadlines) { deadline in
                            NavigationLink(value: deadline) {
                                Label(deadline.name, systemImage: deadline.icon)
                                    .foregroundStyle(DLCustomisation.getColor(colorId: deadline.colorId))
                            }
                        }
                    }
                    /// Otherwise show error
                } else {
                    Label("Create a Deadline on another device", systemImage: "macbook.and.iphone")
                }
            }
            .navigationTitle("Deadlines")
            .navigationDestination(for: Deadline.self) { deadline in
                DeadlineView(deadline: deadline)
            }
        }
    }
}
