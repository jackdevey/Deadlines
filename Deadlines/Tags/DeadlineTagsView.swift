//
//  DeadlineTagsView.swift
//  Deadlines
//
//  Created by Jack Devey on 11/01/2023.
//

import SwiftUI

struct DeadlineTagsView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var tags: FetchedResults<Tag>
    
    // View context
    @Environment(\.managedObjectContext) private var viewContext
    
    // Deadline to add tags to
    @ObservedObject var deadline: Item
    
    // New tag text
    @State var newTagText: String = ""
    
    var body: some View {
        List {
            // New tag
            Section {
                TextField("New tag", text: $newTagText)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        withAnimation {
                            newTag()
                        }
                    }
                    .padding(5)
            }
            // Display each tag
            ForEach(tags) { tag in
                TagItem(tag: tag)
            }
            // When tag deleted
            .onDelete { offsets in
                withAnimation {
                    offsets.map({ tags[$0] })
                        .forEach(deleteTag)
                }
            }
        }
        // Navigation title
        .navigationTitle("Tags")
        // On disappear, save
        .onDisappear {
            _ =  try? viewContext.saveIfNeeded()
        }
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
    
    func newTag() {
        // If text is already taken
        for tag in tags {
            if tag.text == newTagText {
                Alert(title: "Tag '\(newTagText)' already exists").show()
                return
            }
        }
        // Create new tag
        let tag = Tag(context: viewContext)
        tag.id = UUID()
        tag.text = newTagText
        tag.timestamp = Date.now
        // Add to deadline
        deadline.addToTags(tag)
        // Clear textfield
        newTagText = ""
    }
    
    func deleteTag(_ tag: Tag) {
        // Remove from deadline
        deadline.removeFromTags(tag)
        // Remove entirely
        viewContext.delete(tag)
    }
    
}
