//
//  LinkRowView.swift
//  Deadlines
//
//  Created by Jack Devey on 20/01/2023.
//

import SwiftUI

struct TodoRowView: View {
    
    @Environment(\.managedObjectContext) var context
    
    // Params
    @ObservedObject var todo: DeadlineTodo
    
    // Is showing editor
    @State private var showEditSheet = false
    
    var body: some View {
        // View body
        Button {
            todo.done.toggle()
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
        }
        // Edit sheet
        .sheet(isPresented: $showEditSheet) {
            TodoManagerSheet(
                mode: .edit,
                name: todo.name ?? "",
                description: todo.desc ?? "",
                done: todo.done
            ) { name, description, done in
                // Change name & url + done
                todo.name = name
                todo.desc = description
                todo.done = done
                // Save
                _=try? context.saveIfNeeded()
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
    
}
