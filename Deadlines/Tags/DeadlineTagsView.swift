////
////  DeadlineTagsView.swift
////  Deadlines
////
////  Created by Jack Devey on 11/01/2023.
////
//
//import SwiftUI
//import SwiftUIFlowLayout
//
//struct DeadlineTagsView: View {
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
//        animation: .default)
//    private var tags: FetchedResults<Tag>
//    
//    // View context
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    // Deadline to add tags to
//    @ObservedObject var deadline: Item
//    
//    // New tag text
//    @State var newTagText: String = ""
//    
//    var body: some View {
//        List {
//            // New tag
//            Section {
//                TextField("New tag", text: $newTagText)
//                    .autocorrectionDisabled(true)
//                #if os(iOS)
//                    .textInputAutocapitalization(.never)
//                #endif
//                    .onSubmit {
//                        withAnimation {
//                            newTag()
//                        }
//                    }
//                    .padding(5)
//                FlowLayout(mode: .scrollable,
//                           items: tags.map({$0}),
//                           itemSpacing: 4) { tag in
//                    
//                    Text("#\(tag.text ?? "unknown")")
//                        .font(.system(.headline, design: .rounded))
//                        .foregroundColor(.white)
//                        .padding(8)
//                        .bold()
//                        .onPress {
//                            if deadline.tags!.contains(tag) {
//                                deadline.removeFromTags(tag)
//                            } else {
//                                deadline.addToTags(tag)
//                            }
//                        }
//                        .background(
//                            RoundedRectangle(cornerRadius: 7)
//                                .foregroundColor(
//                                    deadline.tags!.contains(tag) ? Color.indigo : Color.secondarySystemFill
//                                )
//                        )
//                }
//            }
//            
//        }
//        // Navigation title
//        .navigationTitle("Tags")
//        // On disappear, save
//        .onDisappear {
//            _ =  try? viewContext.saveIfNeeded()
//        }
//    }
//    
//    func newTag() {
//        // If text is already taken
//        for tag in tags {
//            if tag.text == newTagText {
//                Alert(title: "Tag '\(newTagText)' already exists").show()
//                return
//            }
//        }
//        // Create new tag
//        let tag = Tag(context: viewContext)
//        tag.id = UUID()
//        tag.text = newTagText.lowercased().replacingOccurrences(of: " ", with: "")
//        tag.timestamp = Date.now
//        // Add to deadline
//        deadline.addToTags(tag)
//        // Clear textfield
//        newTagText = ""
//    }
//    
//    func deleteTag(_ tag: Tag) {
//        // Remove from deadline
//        deadline.removeFromTags(tag)
//        // Remove entirely
//        viewContext.delete(tag)
//    }
//    
//}
