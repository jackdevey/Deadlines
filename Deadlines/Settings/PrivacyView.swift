//
//  PrivacyView.swift
//  Deadlines
//
//  Created by Jack Devey on 15/01/2023.
//

import CoreData
import SwiftUI
import UniformTypeIdentifiers


struct PrivacyView: View {
    
    // View context
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("useBiometrics") private var useBiometrics = false
    
    // Get if is new install (to set to true)
    @AppStorage("context.newInstall") var isNewInstall = true
    
    @State var confirmDelete = false
    
    @State private var showingExporter = false

    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    var body: some View {
        List {
            // Show title
            Section {
                Text("Deadlines stores encrypted data in iCloud to enable data sharing between your Apple devices")
                    .foregroundColor(.secondary)
                    .font(.headline)
                Text("Data is encrypted with a key stored in your iCloud keychain. If you lose access to this, you will not be able to access any of your Deadlines in this app.")
                    .foregroundColor(.secondary)
            }
            // App security section
            Section(
                header: Text("App Security"),
                footer: Text("Adding an extra layer of security can help to protect your Deadlines.")
            ) {
                Toggle(isOn: $useBiometrics) {
                    NiceIconLabel(text: "Face Unlock", color: .systemGreen, iconName: "faceid")
                }
            }
            // Manage data section
            Section(
                header: Text("Manage your data"),
                footer: Text("You have complete control over your data. If you don't feel happy, you can delete all app data immediately, or export it for use elsewhere.")
            ) {
                Link(destination: URL(string: "https://deadlines.jw3.uk/privacy")!) {
                    NiceIconLabel(text: "Privacy Policy", color: .systemIndigo, iconName: "doc")
                }
                    .tint(.primary)
                MYNavigationLink {
                    exportAllData()
                } label: {
                    NiceIconLabel(text: "Export all data", color: .systemBlue, iconName: "square.and.arrow.up")
                }
                    .tint(.primary)
                MYNavigationLink {
                    confirmDelete = true
                } label: {
                    NiceIconLabel(text: "Delete all data", color: .systemRed, iconName: "bin.xmark")
                }
                    .tint(.primary)
            }
        }
        // Delete? alert
        .alert("Are you sure?", isPresented: $confirmDelete) {
            Text("This is permanent, deleted data cannot be recovered")
            // Confirm button
            Button("Confirm", role: .destructive) {
                deleteAllData()
                Alert(title: "Data deleted").show()
                confirmDelete = false
                isNewInstall = true
            }
            // Cancel button
            Button("Cancel", role: .cancel) {
                confirmDelete = false
            }
        }
        // Show title
        .navigationTitle("Privacy & Security")
    }
    
    func exportAllData() {
        // Export helper
        func exportType<T: Encodable>(data: [T], fileName: String) -> URL {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            try? JSONEncoder().encode(data).write(to: url)
            return url
        }
        // List of urls
        var urls: [URL] = []
        // Export deadlines
        let items: NSFetchRequest<Item>
        items = Item.fetchRequest()
        urls.append(exportType(data: (try? viewContext.fetch(items)) ?? [], fileName: "deadlines.json"))
        // Export todos
        let todos: NSFetchRequest<DeadlineTodo>
        todos = DeadlineTodo.fetchRequest()
        urls.append(exportType(data: (try? viewContext.fetch(todos)) ?? [], fileName: "todos.json"))
        // Export links
        let links: NSFetchRequest<DeadlineLink>
        links = DeadlineLink.fetchRequest()
        urls.append(exportType(data: (try? viewContext.fetch(links)) ?? [], fileName: "links.json"))
        // Export tags
        let tags: NSFetchRequest<Tag>
        tags = Tag.fetchRequest()
        urls.append(exportType(data: (try? viewContext.fetch(tags)) ?? [], fileName: "tags.json"))
        // Show sheet
        let activityController = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    func deleteAllData() {
        // Delete all items
        let items: NSFetchRequest<Item>
        items = Item.fetchRequest()
        items.includesPropertyValues = false
        for item in (try? viewContext.fetch(items)) ?? [] {
            viewContext.delete(item)
        }
        // Delete all todos
        let todos: NSFetchRequest<DeadlineTodo>
        todos = DeadlineTodo.fetchRequest()
        todos.includesPropertyValues = false
        for todo in (try? viewContext.fetch(todos)) ?? [] {
            viewContext.delete(todo)
        }
        // Delete all links
        let links: NSFetchRequest<DeadlineLink>
        links = DeadlineLink.fetchRequest()
        links.includesPropertyValues = false
        for link in (try? viewContext.fetch(links)) ?? [] {
            viewContext.delete(link)
        }
        // Delete all tags
        let tags: NSFetchRequest<Tag>
        tags = Tag.fetchRequest()
        tags.includesPropertyValues = false
        for tag in (try? viewContext.fetch(tags)) ?? [] {
            viewContext.delete(tag)
        }
        // Save the deletions to the persistent store
        try? viewContext.save()
    }
}

