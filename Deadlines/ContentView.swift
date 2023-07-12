//
//  ContentView.swift
//  Deadlines
//
//  Created by Jack Devey on 23/12/2022.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Get viewContext
    @Environment(\.modelContext) private var context
    
//    /// Fetch items
//
//    // NOT submitted
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
//        predicate: NSPredicate(format: "submitted == false"),
//        animation: .default)
//    private var items: FetchedResults<Item>
//    // Submitted
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
//        predicate: NSPredicate(format: "submitted == true"),
//        animation: .default)
//    private var submittedItems: FetchedResults<Item>
//    
//    /// Fetch Tags
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var tags: FetchedResults<Tag>
//    
//    
//    @State private var showNew = false
//    @State private var showSettings = false
//    @State private var selection: Item?
//    
//    @AppStorage("useBiometrics") private var useBiometrics = false
//    @State private var showContent = false
//    
//    @State private var date = Date()
//    @State private var name = ""
//    
//    @State private var search = ""
//    
//    var preFilteredDeadlines: [Item] {
//        if search.isEmpty {
//            return items.filter({ _ in true })
//        } else {
//            return items.filter { $0.name!.contains(search) || $0.tagNames.contains(search) }
//        }
//    }
//    
//    var filteredCompletedDeadlines: [Item] {
//        if search.isEmpty {
//            return submittedItems.filter({ _ in true })
//        } else {
//            return submittedItems.filter { $0.name!.contains(search) || $0.tagNames.contains(search) }
//        }
//    }
//    
//    var filteredTags: [Tag] {
//        if search.isEmpty {
//            return tags.filter({ _ in true })
//        } else {
//            return tags.filter { search.first == "#" && ("#\($0.text!)").contains(search) }
//        }
//    }
    
    @Query(sort: \.due, order: .reverse) var deadlines: [Deadline]
    
    @State private var showingDeleteAlert: Bool = false
    @State private var settings: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(deadlines) { deadline in
                    deadline.ListView()
                }
//                .onMove { deadlines.move(fromOffsets: $0, toOffset: $1) }
            }
            .navigationTitle("Deadlines")
            .toolbar {
                // Edit deadlines
//                ToolbarItem(placement: .topBarLeading) {
//                    EditButton()
//                }
                // New deadline
                ToolbarItem {
                    Button {
                        let deadline = Deadline(name: "", due: Date(), icon: "", colorId: 0)
                        context.insert(deadline)
                    } label: {
                        Label("New", systemImage: "plus.app")
                    }
                }
                // Settings
                ToolbarItem {
                    Button {
                        settings = true
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
            }
        }
        .sheet(isPresented: $settings) {
            SettingsSheet(isShowing: $settings)
        }
        
//        VStack {
//            if showContent {
//                NavigationStack {
//                    List {
//                        ForEach(preFilteredDeadlines) { item in
//                            NavigationLink(destination: DeadlineView(item: item)) {
//                                item.ListView()
//                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                                        Button {
//                                            item.submitted = true
//                                        } label: {
//                                            Label("Submit", systemImage: "paperplane.fill")
//                                        }
//                                        .tint(.systemBlue)
//                                    }
////                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
////                                    Button {
////                                        print("Awesome!")
////                                    } label: {
////                                        Label("Pin", systemImage: "pin")
////                                    }
////                                    .tint(.systemBlue)
////                                }
////                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
////                                    Button {
////                                        print("Awesome!")
////                                    } label: {
////                                        Label("See", systemImage: "square")
////                                    }
////                                    .tint(.systemGreen)
////                                }
//                            }
//                        }
//                        .onDelete { offsets in
//                            // Delete a link from the deadline
//                            withAnimation {
//                                offsets.map { preFilteredDeadlines[$0] }
//                                    .forEach(viewContext.delete)
//                                //items.remove(atOffsets: offsets)
//                                Store().save(viewContext: viewContext) // Save changes
//                            }
//                        }
//                        // Show completed deadlines (if any)
//                        if filteredCompletedDeadlines.count > 0 {
//                            Section(header: Text("Submitted")) {
//                                ForEach(filteredCompletedDeadlines) { item in
//                                    NavigationLink(destination: DeadlineView(item: item)) {
//                                        item.ListView()
//                                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                                                Button {
//                                                    item.submitted = false
//                                                } label: {
//                                                    Label("Unsubmit", systemImage: "arrowshape.turn.up.backward")
//                                                }
//                                                .tint(.systemBlue)
//                                            }
//                                    }
//                                }
//                                .onDelete { offsets in
//                                    // Delete a link from the deadline
//                                    withAnimation {
//                                        offsets.map { filteredCompletedDeadlines[$0] }
//                                            .forEach(viewContext.delete)
//                                        //items.remove(atOffsets: offsets)
//                                        Store().save(viewContext: viewContext) // Save changes
//                                    }
//                                }
//                            }
//                            .headerProminence(.increased)
//                        }
//
//                    }
//                    .navigationTitle("Deadlines")
//                    .listStyle(.sidebar)
//                    .searchable(text: $search) {
//                        ForEach(filteredTags) { tag in
//                            tag.LabelView()
//                                .searchCompletion("#\(tag.text ?? "Unknown")")
//                        }
//                    }
//                    .toolbar {
//                        ToolbarItem(id: "edit", placement: .navigationBarLeading) {
//                            EditButton()
//                        }
//                        ToolbarItem(id: "new") {
//                            Button {
//                                $showNew.wrappedValue.toggle()
//                            } label: {
//                                Label("New Deadline", systemImage: "plus")
//                            }
//                        }
//                        ToolbarItem(id: "settings") {
//                            Button {
//                                $showSettings.wrappedValue.toggle()
//                            } label: {
//                                Label("Settings", systemImage: "gearshape")
//                            }
//                        }
//                    }
//                    .navigationDestination(isPresented: $showSettings) {
//                        SettingsView()
//                    }
//                    .sheet(isPresented: $showNew) {
//                        NewEditDeadlineView(
//                            cancelHandler: {
//                                // Close the view
//                                showNew = false
//                            },
//                            confirmHandler: { name, date, color, iconName in
//                                // Make a new deadline
//                                let deadline = Item(context: viewContext)
//                                deadline.id = UUID()
//                                deadline.name = name
//                                deadline.date = date
//                                deadline.color = color
//                                deadline.iconName = iconName
//                                // Close the view
//                                showNew = false
//                                // Save if needed
//                                _ = try? viewContext.saveIfNeeded()
//                            }
//                        )
//                    }
//                }
//                
//            }
//        }
//        .onAppear(perform: authenticate)
    }
    
//    func authenticate() {
//        let context = LAContext()
//        var error: NSError?
//        
//        // If not using biometrics
//        if !useBiometrics {
//            showContent = true
//            return
//        }
//
//        // check whether biometric authentication is possible
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            // it's possible, so go ahead and use it
//            let reason = "We need to unlock your data."
//
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//                // authentication has now completed
//                if success {
//                    showContent = true
//                    // authenticated successfully
//                } else {
//                    // there was a problem
//                }
//            }
//        } else {
//            // no biometrics
//            showContent = true
//        }
//    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.id = UUID()
//            newItem.timestamp = Date()
//            newItem.name = "a"
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
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
