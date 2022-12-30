//
//  NotesView.swift
//  Deadlines
//
//  Created by Jack Devey on 30/12/2022.
//

import SwiftUI

struct NotesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // Item to show links for
    @ObservedObject var item: Item
    
    @State var note: String
    
    
    
    // Constructor hack to allow the use
    // of links as state (this is so the
    // list will update)
    init(item: Item) {
        self.item = item
        self.note = item.note ?? ""
    }
    
    var body: some View {
        List {
            TextEditor(text: $note)
            Button("Save") {
                item.note = note
                try? viewContext.save()
            }
        }
        .navigationTitle("Notes")
    }
}
