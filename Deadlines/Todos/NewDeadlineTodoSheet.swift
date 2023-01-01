//
//  NewDeadline.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct NewDeadlineTodoSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    
    @State private var showURLInvalid: Bool = false
    @State private var showEmptyName: Bool = false
    var create: (DeadlineTodo) -> ()
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
            }
            .navigationTitle("New item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(id: "cancel", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(id: "create", placement: .confirmationAction) {
                    Button {
                        // Name is empty
                        if name.isEmpty {
                            showEmptyName = true
                            return
                        }
                        // New DeadlinTodo object
                        let todo = DeadlineTodo(context: viewContext)
                        todo.id = UUID()
                        todo.name = name
                        // Pass to DeadlineTodoView to manage
                        // placement & save
                        create(todo)
                        dismiss()
                    } label: {
                        Text("Create")
                    }
                }
            }
            // If name is empty
            .alert("Name is empty", isPresented: $showEmptyName) {}
        }
    }
}
