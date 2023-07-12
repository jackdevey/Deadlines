////
////  LinkRowView.swift
////  Deadlines
////
////  Created by Jack Devey on 20/01/2023.
////
//
//import SwiftUI
//
//struct LinkRowView: View {
//    
//    @Environment(\.managedObjectContext) var context
//    
//    // Params
//    @StateObject var link: DeadlineLink
//    
//    // Pasteboard
//    private let pasteboard = UIPasteboard.general
//    
//    // Is showing editor
//    @State private var showEditSheet = false
//    
//    var body: some View {
//        // View body
//        Link(destination: link.url ?? URL(string: "https://example.com")!) {
//            LinkView(name: link.name, url: link.url, imageURL: link.imageURL, done: link.done)
//                .id(link.placement)
//        }
//        .tint(.primary)
//        // On swipe right
//        .swipeActions(edge: .leading) {
//            toggleDoneButton
//                .tint(.green)
//        }
//        // Menu
//        .contextMenu {
//            // Edit/done section
//            Section {
//                toggleDoneButton
//                editLinkButton
//            }
//            // Link section
//            Section("URL") {
//                openLinkButton
//                copyLinkButton
//                shareLinkButton
//            }
//        }
//        // Edit sheet
//        .sheet(isPresented: $showEditSheet) {
//            LinkManagerSheet(
//                mode: .edit,
//                name: link.name ?? "",
//                url: link.url?.absoluteString ?? "",
//                done: link.done
//            ) { name, url, done in
//                // Change name & url + done
//                link.name = name
//                link.url = url
//                link.done = done
//                // Save
//                _=try? context.saveIfNeeded()
//                // Close sheet
//                showEditSheet.toggle()
//            }
//        }
//    }
//    
//    var toggleDoneButton: some View {
//        // Toggle done
//        Button {
//            link.done.toggle()
//        } label: {
//            Label(link.done ? "Set to do" : "Set done", systemImage: link.done ? "circle.slash" : "checkmark.circle")
//        }
//    }
//    
//    var editLinkButton: some View {
//        // Edit link
//        Button {
//            showEditSheet.toggle()
//        } label: {
//            Label("Edit link", systemImage: "square.and.pencil")
//        }
//    }
//    
//    var openLinkButton: some View {
//        // Open in browser
//        Link(destination: link.url ?? URL(string: "https://example.com")!) {
//            Label("Open in browser", systemImage: "safari")
//        }
//    }
//    
//    var copyLinkButton: some View {
//        // Copy link
//        Button {
//            pasteboard.string = link.url?.absoluteString ?? ""
//        } label: {
//            Label("Copy to clipboard", systemImage: "doc.on.doc")
//        }
//    }
//    
//    var shareLinkButton: some View {
//        // Share link
//        ShareLink(item: link.url ?? URL(string: "https://example.com")!)
//    }
//    
//}
