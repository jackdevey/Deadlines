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
    @ObservedObject var item: Item
    // The links themselves
    // (State so supports changes)
    @State var links: [DeadlineLink]
    // The store class functions
    var store = Store()
    
    // Constructor hack to allow the use
    // of links as state (this is so the
    // list will update)
    init(item: Item) {
        self.item = item
        self.links = item.links?.array as! [DeadlineLink]
    }
    
    var body: some View {
        
        List {
            // Show each link for the item
            ForEach(links.sorted(using: SortDescriptor(\DeadlineLink.placement))) { link in
                // Show each link as a link (with label)
                Link(destination: link.url!) {
                    Text(link.name!)
                }
            }
            // When a link is moved (order has changed)
            .onMove { from, to in
                // Move the links around as changed
                from.map { links[$0] }.forEach{ link in
                    links.move(fromOffsets: from, toOffset: to)
                }
                // Loop through links and update placement
                for idx in links.indices {
                    links[idx].placement = Int16(idx)
                }
                // Save changes
                store.save(viewContext: viewContext)
            }
            // When a link has been deleted
            .onDelete { offsets in
                // Delete a link from the deadline
                withAnimation {
                    offsets.map { links[$0] }.forEach(viewContext.delete)
                    links.remove(atOffsets: offsets)
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
            NewDeadlineLinkSheet { link in
                // Set placement to end
                link.placement = Int16(links.endIndex)
                // Save changes
                item.addToLinks(link)
                store.save(viewContext: viewContext)
                // Add link to links list
                withAnimation {
                    links.append(link)
                }
            }
        }
    }
}
