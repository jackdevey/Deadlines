//
//  ContentView.swift
//  Deadlines
//
//  Created by Jack Devey on 23/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showingNewDeadline = false
    @State private var date = Date()
    @State private var name = ""

    var body: some View {
        
        NavigationStack {
            List(items) { item in
                
                NavigationLink(item.name!) {
                    Text(item.date!, style: .date)
                    .navigationTitle(item.name!)
                }

            }
            .navigationTitle("Deadlines")
            .toolbar {
                Button("New") {
                    $showingNewDeadline.wrappedValue.toggle()
                }
            }
            
            .sheet(isPresented: $showingNewDeadline) {
                NavigationView {
                    Form {
                        TextField("Name", text: $name)
                        DatePicker("Due in", selection: $date, in: Date.now...)
                        Button("Create") {
                            withAnimation {
                                
                                if name.isEmpty {
                                    return
                                }
                                
                                let newItem = Item(context: viewContext)
                                newItem.id = UUID()
                                newItem.date = $date.wrappedValue
                                newItem.name = $name.wrappedValue

                                do {
                                    try viewContext.save()
                                } catch {
                                    // Replace this implementation with code to handle the error appropriately.
                                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }
                            $showingNewDeadline.wrappedValue.toggle()
                        }
                    }
                    .navigationTitle("New deadline")
                }
            }
            Text("Alpha")
        }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.timestamp = Date()
            newItem.name = "a"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
