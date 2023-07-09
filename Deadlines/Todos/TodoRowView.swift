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
    @StateObject var todo: DeadlineTodo
    
    // Is showing editor
    @State private var showEditSheet = false
    // Is showing add link sheet
    @State private var showAddLinkSheet = false
    
    var body: some View {
        // View body
        Button {
            todo.done.toggle()
        } label: {
            VStack(alignment: .leading) {
                TodoView(name: todo.name, description: todo.desc, done: todo.done)
                VStack {
                    ForEach(todo.links?.allObjects as? [DeadlineLink] ?? []) { link in
                        LinkView(name: link.name, url: link.url, imageURL: link.imageURL, done: link.done)
                    }
                    .padding(0)
                    .scaleEffect(0.75)
                }
                .background(.tertiarySystemGroupedBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
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
        // Manage links sheet
        .sheet(isPresented: $showAddLinkSheet) {
            if let deadline = todo.deadline {
                AttachLinksSheet(item: deadline, handler:  { selection in
                    // Set the links
                    todo.links = selection as NSSet
                    // Save
                    _=try? context.saveIfNeeded()
                }, selection: todo.links as! Set<DeadlineLink>)
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
