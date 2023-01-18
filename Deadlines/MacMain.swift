//
//  MacMain.swift
//  Deadlines
//
//  Created by Jack Devey on 18/01/2023.
//

import SwiftUI

struct MacMain: View {
    
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    // Get viewContext
    @Environment(\.managedObjectContext) private var viewContext
    
    /// Fetch items

    // NOT submitted
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
        predicate: NSPredicate(format: "submitted == false"),
        animation: .default)
    private var items: FetchedResults<Item>
    // Submitted
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
        predicate: NSPredicate(format: "submitted == true"),
        animation: .default)
    private var submittedItems: FetchedResults<Item>
    
    @State private var showingNewDeadline = false
    
    @State private var selection: Item? = nil
    
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(items, id: \.id, selection: $selection) { item in
                NavigationLink(value: item) {
                    item.ListView()
                }
            }
            .navigationTitle(Text("Deadlines"))
            .toolbar {
                // New deadline button
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingNewDeadline = true
                    } label: {
                        Label("New Deadline", systemImage: "plus")
                    }
                }
            }
        } content: {
            ZStack {
                if let deadline = selection {
                    DeadlineView(item: deadline)
                        .id(deadline.id)
                }
            }
        } detail: {
            Text("s")
        }
        .sheet(isPresented: $showingNewDeadline) {
            NewEditDeadlineView(
                cancelHandler: {
                    // Close the view
                    showingNewDeadline = false
                },
                confirmHandler: { name, date, color, iconName in
                    // Make a new deadline
                    let deadline = Item(context: viewContext)
                    deadline.id = UUID()
                    deadline.name = name
                    deadline.date = date
                    deadline.color = color
                    deadline.iconName = iconName
                    // Close the view
                    showingNewDeadline = false
                    // Save if needed
                    _ = try? viewContext.saveIfNeeded()
                }
            )
        }
    }
}
