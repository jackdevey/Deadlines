//
//  DeadlineLinkView.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct DeadlineLinkView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingNewLink = false
    
    // Item to show links for
    @StateObject var item: Item

    // The store class functions
    var store = Store()
    
    // Constructor hack to allow the use
    // of links as state (this is so the
    // list will update)
    
    var list: [DeadlineLink] {
        item.links?.sortedArray(using: [NSSortDescriptor(keyPath: \DeadlineLink.placement, ascending: false)]) as? [DeadlineLink] ?? []
    }
    
    var body: some View {
        
        List {
            // Show each link for the item
            ForEach(list) { link in
                // Show each link as a link (with label)
                LinkRowView(link: link)
            }
//            // When a link is moved (order has changed)
//            .onMove { from, to in
//                // Move the links around as changed
//                from.map { links[$0] }.forEach{ link in
//                    links.move(fromOffsets: from, toOffset: to)
//                }
//                // Loop through links and update placement
//                for idx in links.indices {
//                    links[idx].placement = Int16(idx)
//                }
//                // Save changes
//                store.save(viewContext: viewContext)
//            }
            // When a link has been deleted
            .onDelete { offsets in
                // Delete a link from the deadline
                withAnimation {
                    //offsets.map { item.links[$0] }.forEach(viewContext.delete)
                    store.save(viewContext: viewContext) // Save changes
                }
            }
        }
        .navigationTitle("Links")
        .toolbar {
            EditButton()
            // New button
            Button() {
                showingNewLink.toggle()
            } label: {
                Label("New", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showingNewLink) {
            LinkManagerSheet(
                mode: .new
            ) { name, url in
                // New link
                let link = DeadlineLink(context: viewContext)
                link.id = UUID()
                link.name = name
                link.url = url
                link.placement = Int16(item.links?.allObjects.count ?? 0)
                // Add to deadline
                item.addToLinks(link)
                // Save
                _=try? viewContext.saveIfNeeded()
                // Close
                showingNewLink.toggle()
            }
        }
    }
}
