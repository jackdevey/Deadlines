//
//  DeadlineTagsView.swift
//  Deadlines
//
//  Created by Jack Devey on 11/01/2023.
//

import SwiftUI

struct DeadlineTagsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) private var tags: FetchedResults<Tag>
    
    @ObservedObject var deadline: Item
    
    @State var newTagName: String = ""
    
    var body: some View {
        List {
            Section {
                TextField("Add new tag", text: $newTagName)
                    .onSubmit {
                        withAnimation {
                            // Create new tag
                            let tag = Tag(context: viewContext)
                            tag.id = UUID()
                            tag.text = newTagName
                            tag.timestamp = Date.now
                            // Clear newtag var
                            newTagName = ""
                            // Save
                            try? viewContext.save()
                        }
                    }
                    .padding([.vertical], 5)
            }
            ForEach(tags) { tag in
                // Display each tag
                TagItem(tag: tag)
            }
            .onDelete { offsets in
                    // Delete a link from the deadline
                    withAnimation {
                        offsets.map { tags[$0] }
                            .forEach(viewContext.delete)
                        //items.remove(atOffsets: offsets)
                        Store().save(viewContext: viewContext) // Save changes
                    }
            }
            
        }
        // Navigation title
        .navigationTitle("Tags")
    }
    
    @ViewBuilder
    func TagItem(tag: Tag) -> some View {
        Button {
            if deadline.tags!.contains(tag) {
                deadline.removeFromTags(tag)
            } else {
                deadline.addToTags(tag)
            }
        } label: {
            HStack {
                tag.LabelView()
                Spacer()
                if deadline.tags!.contains(tag) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                }
            }
            .tint(.primary)
        }
    }
}
