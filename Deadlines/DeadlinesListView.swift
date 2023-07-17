//
//  ContentView.swift
//  Deadlines
//
//  Created by Jack Devey on 23/12/2022.
//

import SwiftUI
import SwiftData

struct DeadlinesListView: View {
    // Get viewContext
    @Environment(\.modelContext) private var context
    
    @Query(sort: \.due, order: .reverse) var deadlines: [Deadline]
    
    @Environment(\.scenePhase) private var scenePhase
    
    
    @State private var settings: Bool = false
    @State private var newDeadline: Bool = false
    
    @StateObject private var filterer = DeadlineFilterer()
    
    @State private var path = NavigationPath()

    var body: some View {
        List(filterer.filter(unfiltered: deadlines)) { deadline in
            NavigationLink(value: AppRouter.details(deadline)) {
                deadline.ListView()
                // Show submitted icon
                    .if(deadline.isSubmitted) {
                        $0.badge(
                            Text(" \(Image(systemName: "paperplane")) ")
                                .foregroundStyle(.blue)
                        )
                    }
                // Show urgent icon
                    .if(deadline.isUrgent) {
                        $0.badge(
                            Text(" \(Image(systemName: "exclamationmark")) ")
                                .foregroundStyle(.red)
                        )
                    }
            }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    deadline.context?.delete(deadline)
                    try? context.save()
                } label: {
                    Label("Delete", systemImage: "bin.xmark")
                }
            }
//                .onMove { deadlines.move(fromOffsets: $0, toOffset: $1) }
        }
        .navigationTitle("Deadlines")
        .toolbar {
            // Filter
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    // Filter by flags
                    Section {
                        // Submitted
                        Toggle(isOn: $filterer.isSubmitted) {
                            Label("Submitted", systemImage: "paperplane")
                        }
                        // Urgent
                        Toggle(isOn: $filterer.isUrgent) {
                            Label("Urgent", systemImage: "exclamationmark")
                        }
                    } header: {
                        Text("Flags")
                    }
                    // Expired
                    Toggle(isOn: $filterer.hasExpired) {
                        Label("Expired", systemImage: "clock.badge.exclamationmark")
                    }
                } label: {
                    Label("Filter", systemImage: filterer.hasFilterApplied ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                }
            }
            // New deadline
            ToolbarItem {
                Button {
                    newDeadline = true
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
        .sheet(isPresented: $settings) {
            SettingsSheet(isShowing: $settings)
        }
        .sheet(isPresented: $newDeadline) {
            NewEditDeadlineView(
                cancelHandler: {
                    // Close the view
                    newDeadline = false
                },
                confirmHandler: { name, date, color, iconName in
                    // Make a new deadline
                    let deadline = Deadline(name: name, due: date, icon: iconName, colorId: color)
                    // Close the view
                    newDeadline = false
                    // Save if needed
                    context.insert(deadline)
                    // Navigate to the new deadline
                    path.append(deadline)
                    try? context.save()
                }
            )
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
