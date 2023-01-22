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

    // The store class functions
    var store = Store()
    
    // Constructor hack to allow the use
    // of links as state (this is so the
    // list will update)
    
    @FetchRequest var links: FetchedResults<DeadlineLink>
    
    init(item: Item) {
        self.item = item
            _links = FetchRequest(
                entity: DeadlineLink.entity(),
                sortDescriptors: [
                    NSSortDescriptor(keyPath: \DeadlineLink.placement, ascending: true)
                ],
                predicate: NSPredicate(format: "deadline == %@", item)
            )
    }
    
    var body: some View {
        
        List {
            // Show each link for the item
            ForEach(links) { link in
                // Show each link as a link (with label)
                LinkRowView(link: link)
            }
            // When a link is moved (order has changed)
            .onMove { from, to in
                // Map to array
                var linksArray = links.map{$0}
                // Let swift handle this cus is weird like
                // why is there a set of moving? I thought
                // only one moves
                linksArray.move(fromOffsets: from, toOffset: to)
                // Reorder, the whole array to update
                // placement info
                for idx in linksArray.indices {
                    linksArray[idx].placement = Int16(idx)
                }
                // Save changes
                _=try? viewContext.saveIfNeeded()
            }
            // When a link has been deleted
            .onDelete { offsets in
                // Delete a link from the deadline
                withAnimation {
                    // Map to array
                    var linksArray = links.map{$0}
                    // Let swift handle this cus is weird like
                    // why is there a set of deleted? I thought
                    // only one can be deleted
                    offsets.map { linksArray[$0] }.forEach(viewContext.delete)
                    linksArray.remove(atOffsets: offsets)
                    // Reorder, the whole array to update
                    // placement info
                    for idx in linksArray.indices {
                        linksArray[idx].placement = Int16(idx)
                    }
                    // Save changes
                    _=try? viewContext.saveIfNeeded()
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
            ) { name, url, _ in
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
