//
//  LinkEditor.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct LinkEditor: View {
    
    @ObservedObject var item: Item
    @Environment(\.managedObjectContext) private var viewContext
    
    var store: Store = Store()
    
    var body: some View {
        // Manage a list of links for the item
        var links = (item.links?.allObjects as! [DeadlineLink])
        
        List {
            // Show each link for the item
            ForEach(links) { link in
                Label(link.name!, systemImage: "link")
            }
            // When a link is moved (order has changed)
            .onMove { from, to in
                from.map { links[$0] }.forEach{ link in
                    link.placement = Int16(to)
                    links.move(fromOffsets: from, toOffset: to)
                }
                
            }
            // When a link has been deleted
            .onDelete { offsets in
                // Delete a link from the deadline
                withAnimation {
                    offsets.map { links[$0] }.forEach(viewContext.delete)
                    store.save(viewContext: viewContext) // Save changes
                }
            }
            
        }
        .navigationTitle("Links")
        .toolbar {
            EditButton()
            Button("New") {
                let link = DeadlineLink(context: viewContext)
                link.id = UUID()
                link.name = "Test"
                
                // Add new link to the deadline
                withAnimation {
                    item.addToLinks(link)
                    store.save(viewContext: viewContext) // Save changes
                }
                
            }
        }
    }
}
