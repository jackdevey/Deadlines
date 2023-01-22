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
    
    func move(from: IndexSet, to: Int) {
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
    
    func delete(offsets: IndexSet) {
        // Let swift handle this cus is weird like
        // why is there a set of deleted? I thought
        // only one can be deleted
        offsets.map { links[$0] }.forEach(viewContext.delete)
        // Reorder, the whole array to update
        // placement info
        for idx in links.indices {
            links[idx].placement = Int16(idx)
        }
        // Save changes
        _=try? viewContext.saveIfNeeded()
    }
    
    var completedCount: some View {
        (Text(String(links.count{ $0.done }))
            .font(.system(.callout, design: .rounded))
            .foregroundColor(.green)
            .bold()
         +
         Text(" of \(links.count)")
            .font(.system(.callout, design: .rounded))
            .foregroundColor(.secondaryLabel)
            .bold())
            .width(50)
    }
    
    var body: some View {
        NavigationLink {
            List {
                // Show each link for the item
                if !links.isEmpty {
                    Section(
                        footer: Text("Logos provided by [Clearbit](https://clearbit.com/logo)")
                    ) {
                        ForEach(links) { link in
                            // Show each link as a link (with label)
                            LinkRowView(link: link)
                        }
                        // When a link is moved (order has changed)
                        .onMove(perform: move)
                        // When a link has been deleted
                        .onDelete(perform: delete)
                    }
                } else {
                    NiceIconLabel(text: "No Links", color: .blue, iconName: "exclamationmark.triangle")
                    // Show new link button
                    MYNavigationLink {
                        showingNewLink.toggle()
                    } label: {
                        Label("New Link", systemImage: "plus")
                            .foregroundColor(.secondaryLabel)
                    }
                }
            }
            .navigationTitle("Links")
            .navigationBarLargeTitleItems(trailing: completedCount)
            .toolbar {
                ToolbarItem() {
                    EditButton()
                    // New button
                }
                ToolbarItem() {
                    Button() {
                        showingNewLink.toggle()
                    } label: {
                        Label("New", systemImage: "plus")
                    }
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
                    link.placement = Int16(links.count)  + 1
                    // Add to deadline
                    item.addToLinks(link)
                    // Save
                    _=try? viewContext.saveIfNeeded()
                    // Close
                    showingNewLink.toggle()
                }
            }
        } label: {
            label
        }
    }
    
    var label: some View {
        HStack {
            // Actual label
            NiceIconLabel(text: "Links", color: .purple, iconName: "link")
            Spacer()
            // Completed count
            completedCount
        }
    }
}

extension Collection {
    func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}

extension NSSet {
    func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}
