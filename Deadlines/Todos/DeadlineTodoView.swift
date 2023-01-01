//
//  DeadlineLinkView.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct DeadlineTodoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingNewLink = false
    
    // Item to show links for
    @ObservedObject var item: Item
    // The links themselves
    // (State so supports changes)
    @State var todos: [DeadlineTodo]
    // The store class functions
    var store = Store()
    
    // Constructor hack to allow the use
    // of links as state (this is so the
    // list will update)
    init(item: Item) {
        self.item = item
        self.todos = item.todos?.array as! [DeadlineTodo]
    }
    
    var body: some View {
        
        List {
            // Show each todo for the item
            ForEach(todos.sorted(using: SortDescriptor(\DeadlineTodo.placement))) { link in
                // Show each link as a link (with label)
                Text(link.name!)
            }
            // When a todo is moved (order has changed)
            .onMove { from, to in
                // Move the links around as changed
                from.map { todos[$0] }.forEach{ link in
                    todos.move(fromOffsets: from, toOffset: to)
                }
                // Loop through todos and update placement
                for idx in todos.indices {
                    todos[idx].placement = Int16(idx)
                }
                // Save changes
                store.save(viewContext: viewContext)
            }
            // When a todo has been deleted
            .onDelete { offsets in
                // Delete a todo from the deadline
                withAnimation {
                    offsets.map { todos[$0] }.forEach(viewContext.delete)
                    todos.remove(atOffsets: offsets)
                    store.save(viewContext: viewContext) // Save changes
                }
            }
        }
        .navigationTitle("Checklist")
        .toolbar {
            EditButton()
            // New button
            Button() {
                showingNewLink.toggle()
            } label: {
                Label("New", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showingNewLink) {
            NewDeadlineTodoSheet { todo in
                // Set placement to end
                todo.placement = Int16(todos.endIndex)
                // Save changes
                item.addToTodos(todo)
                store.save(viewContext: viewContext)
                // Add todo to todos todo
                withAnimation {
                    todos.append(todo)
                }
            }
        }
    }
}
