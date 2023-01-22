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
    
    // Item to show todos for
    @ObservedObject var item: Item
    
    @FetchRequest var todos: FetchedResults<DeadlineTodo>
    
    init(item: Item) {
        self.item = item
        _todos = FetchRequest(
            entity: DeadlineTodo.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \DeadlineTodo.placement, ascending: true)
            ],
            predicate: NSPredicate(format: "deadline == %@", item)
        )
    }
    
    func move(from: IndexSet, to: Int) {
        withAnimation {
            // Map to array
            var todosArray = todos.map{$0}
            // Let swift handle this cus is weird like
            // why is there a set of moving? I thought
            // only one moves
            todosArray.move(fromOffsets: from, toOffset: to)
            // Reorder, the whole array to update
            // placement info
            for idx in todosArray.indices {
                todosArray[idx].placement = Int16(idx)
            }
            // Save changes
            _=try? viewContext.saveIfNeeded()
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            // Map to array
            var todosArray = todos.map{$0}
            // Let swift handle this cus is weird like
            // why is there a set of deleted? I thought
            // only one can be deleted
            offsets.map { todosArray[$0] }.forEach(viewContext.delete)
            todosArray.remove(atOffsets: offsets)
            // Reorder, the whole array to update
            // placement info
            for idx in todosArray.indices {
                todosArray[idx].placement = Int16(idx)
            }
            // Save changes
            _=try? viewContext.saveIfNeeded()
        }
    }
    
    var completedCount: some View {
        (Text(String(todos.count{ $0.done }))
            .font(.system(.callout, design: .rounded))
            .foregroundColor(.green)
            .bold()
         +
         Text(" of \(todos.count)")
            .font(.system(.callout, design: .rounded))
            .foregroundColor(.secondaryLabel)
            .bold())
            .width(50)
    }
    
    var body: some View {
        List {
            ForEach(todos) { todo in
                TodoRowView(todo: todo)
            }
            .onMove(perform: move)
            .onDelete(perform: delete)
        }
        .navigationTitle("Checklist")
        .navigationBarLargeTitleItems(trailing: completedCount)
        .toolbar {
            // Edit todos button
            ToolbarItem(placement: .primaryAction) {
                EditButton()
            }
            // New todo button
            ToolbarItem(placement: .primaryAction) {
                Button() {
                    showingNewTodo.toggle()
                } label: {
                    Label("New", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingNewTodo) {
            TodoManagerSheet(mode: .new) { name, description, done in
                let todo = DeadlineTodo(context: viewContext)
                todo.id = UUID()
                // Set placement to end
                todo.name = name
                //todo.description = description
                todo.done = done
                todo.placement = Int16(todos.count)
                // Save changes
                item.addToTodos(todo)
                _=try? viewContext.saveIfNeeded()
                showingNewTodo.toggle()
            }
        }
    }
}
