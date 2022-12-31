//
//  ContentView.swift
//  Deadlines
//
//  Created by Jack Devey on 23/12/2022.
//

import SwiftUI
import SwiftUIX
import CoreData
import LocalAuthentication

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showNew = false
    @State private var showSettings = false
    
    @AppStorage("useBiometrics") private var useBiometrics = false
    @State private var showContent = false
    
    
    @State private var date = Date()
    @State private var name = ""

    var body: some View {
        
        VStack {
            
            
            if showContent {
                NavigationStack {
                    List(items) { item in
                        
                        NavigationLink(item.name!) {
                            List {
                                HStack {
                                    Text("Due date")
                                    Spacer()
                                    Text(item.date ?? Date.now, style: .date)
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Text("Status")
                                    Spacer()
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.systemGreen)
                                    Text("Complete")
                                        .foregroundColor(.secondary)
                                    Text("100%")
                                        .foregroundColor(.tertiaryLabel)
                                        .monospacedDigit()
                                }
                                Section {
                                    // Todos
                                    NavigationLink(destination: NotesView(item: item)) {
                                        Label("Checklist", systemImage: "checklist")
                                    }
                                    // Notes
                                    NavigationLink(destination: NotesView(item: item)) {
                                        Label("Notes", systemImage: "text.justify.leading")
                                    }
                                    // Links
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
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // If not using biometrics
        if !useBiometrics {
            showContent = true
            return
        }

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    showContent = true
                    // authenticated successfully
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
            showContent = true
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

extension Bundle {
    
    public var appVersionShort: String {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    public var appVersionLong: String {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    public var appName: String {
        if let result = infoDictionary?["CFBundleName"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
}
