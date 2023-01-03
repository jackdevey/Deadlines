//
//  DeadlineLinkView.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct DeadlineTodoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingNewTodo = false
    
    // Item to show links for
    @ObservedObject var deadline: Item
    
    @State var todos: [DeadlineTodo]
        
    init(deadline: Item) {
        self.deadline = deadline
        self.todos = deadline.todos!.array as! [DeadlineTodo]
    }
    
    var body: some View {
        List(todos, id: \.id) { todo in
            TodoView(todo: todo, handler: { todo in
                // Save the change when an item is toggled
                deadline.replaceTodos(at: Int(todo.placement), with: todo)
                try? viewContext.save()
            })
        }
        .navigationTitle("Checklist")
        .toolbar {
            // Percentage reminder
            ToolbarItem(placement: .status) {
                Text(String(deadline.checklistItemsCompletedPercentage) + "% Complete")
            }
            // New todo button
            ToolbarItem(placement: .primaryAction) {
                Button() {
                    showingNewTodo.toggle()
                } label: {
                    Label("New", systemImage: "plus")
                }
            }
            // Edit todos button
            ToolbarItem(placement: .primaryAction) {
                EditButton()
            }
        }
        .sheet(isPresented: $showingNewTodo) {
            NewDeadlineTodoSheet { todo in
                // Set placement to end
                todo.placement = Int16(deadline.checklistItemsTotal)
                // Save changes
                deadline.addToTodos(todo)
                try? viewContext.save()
                // Add todo to todos todo
                withAnimation {
                    todos.append(todo)
                }
            }
        }
    }
}
