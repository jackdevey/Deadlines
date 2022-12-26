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
    
    @State private var showNew = false
    @State private var showSettings = false
    
    
    @State private var date = Date()
    @State private var name = ""

    var body: some View {
        
        NavigationStack {
            List(items) { item in
                
                NavigationLink(item.name!) {
                    List {
                        Section {
                            // Notes
                            Label("Notes", systemImage: "text.justify.leading")
                            // Link
                            NavigationLink(destination: DeadlineLinkView(item: item)) {
                                Label("Links", systemImage: "link")
                            }
                        }
                    }
                    .navigationTitle(item.name!)
                }

            }
            .navigationTitle("Deadlines")
            .toolbar {
                ToolbarItem(id: "new") {
                    Button {
                        $showNew.wrappedValue.toggle()
                    } label: {
                        Label("New Deadline", systemImage: "plus")
                    }
                }
                ToolbarItem(id: "settings") {
                    Button {
                        $showSettings.wrappedValue.toggle()
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
            }
            .navigationDestination(isPresented: $showSettings) {
                Settings()
            }
            .sheet(isPresented: $showNew) {
                NewDeadline()
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
