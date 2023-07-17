//
//  LinkRowView.swift
//  Deadlines
//
//  Created by Jack Devey on 20/01/2023.
//

import SwiftUI

struct TodoRowView: View {
    
    /// Get SwiftData context
    @Environment(\.modelContext) private var context
    
    // Params
    @StateObject var todo: DeadlineTodo
    
    // Is showing editor
    @State private var showEditSheet = false
    // Is showing add link sheet
    @State private var showAddLinkSheet = false
        
    var body: some View {
        // View body
        Button {
            if !todo.done {
                todo.done = true
                ImpactManager.rigid()
            } else {
                todo.done = false
                ImpactManager.soft()
            }
        } label: {
            TodoView(name: todo.name, description: todo.desc, done: todo.done)
        }
        .tint(.primary)
        // On swipe right
        .swipeActions(edge: .leading) {
            toggleDoneButton
                .tint(.green)
        }
        // Menu
        .contextMenu {
            // Edit/done section
            Section {
                toggleDoneButton
                editLinkButton
            }
            
            Section {
                manageLinksButton
            }
        }
        // Edit sheet
        .sheet(isPresented: $showEditSheet) {
            TodoManagerSheet(
                mode: .edit,
                name: todo.name,
                description: todo.desc,
                done: todo.done
            ) { name, description, done in
                // Change name & url + done
                todo.name = name
                todo.desc = description
                todo.done = done
                // Save
                _ = try? context.save()
                // Close sheet
                showEditSheet.toggle()
            }
        }
    }
    
    var toggleDoneButton: some View {
        // Toggle done
        Button {
            todo.done.toggle()
        } label: {
            Label(todo.done ? "Set to do" : "Set done", systemImage: todo.done ? "circle" : "checkmark.circle")
        }
    }
    
    var editLinkButton: some View {
        // Edit link
        Button {
            showEditSheet.toggle()
        } label: {
            Label("Edit to do", systemImage: "square.and.pencil")
        }
    }
    
    var manageLinksButton: some View {
        // Edit link
        Button {
            showAddLinkSheet.toggle()
        } label: {
            Label("Manage links", systemImage: "link")
        }
    }
    
}
