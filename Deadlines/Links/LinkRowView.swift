//
//  LinkRowView.swift
//  Deadlines
//
//  Created by Jack Devey on 20/01/2023.
//

import SwiftUI

struct LinkRowView: View {
    
    @Environment(\.managedObjectContext) var context
    
    // Params
    @StateObject var link: DeadlineLink
    
    // Pasteboard
    private let pasteboard = UIPasteboard.general
    
    // Is showing editor
    @State private var showEditSheet = false
    
    var body: some View {
        // View body
        LinkView(name: link.name, url: link.url, imageURL: link.imageURL)
        // Menu
        .contextMenu {
            editLinkButton
            // Link section
            Section {
                openLinkButton
                copyLinkButton
                shareLinkButton
            }
            //
        }
        // Edit sheet
        .sheet(isPresented: $showEditSheet) {
            LinkManagerSheet(
                mode: .edit,
                name: link.name ?? "",
                url: link.url?.absoluteString ?? ""
            ) { name, url in
                // Change name & url
                link.name = name
                link.url = url
                // Save
                _=try? context.saveIfNeeded()
                // Close sheet
                showEditSheet.toggle()
            }
        }
    }
    
    var editLinkButton: some View {
        // Edit link
        Button {
            showEditSheet.toggle()
        } label: {
            Label("Edit link", systemImage: "square.and.pencil")
        }
    }
    
    var openLinkButton: some View {
        // Open in browser
        Link(destination: link.url ?? URL(string: "https://example.com")!) {
            Label("Open in browser", systemImage: "safari")
        }
    }
    
    var copyLinkButton: some View {
        // Copy link
        Button {
            pasteboard.string = link.url?.absoluteString ?? ""
        } label: {
            Label("Copy to clipboard", systemImage: "doc.on.doc")
        }
    }
    
    var shareLinkButton: some View {
        // Share link
        ShareLink(item: link.url ?? URL(string: "https://example.com")!)
    }
    
}
