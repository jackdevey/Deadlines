////
////  AttachLinksSheet.swift
////  Deadlines
////
////  Created by Jack Devey on 22/01/2023.
////
//
//import SwiftUI
//
//struct AttachLinksSheet: View {
//    
//    // Get dismiss function
//    @Environment(\.dismiss) var dismiss
//    
//    // So that it starts in edit mode
//    @State var editMode: EditMode = .active
//    
//    @ObservedObject var item: Item
//    
//    @FetchRequest var links: FetchedResults<DeadlineLink>
//    
//    @State var selection: Set<DeadlineLink> = Set<DeadlineLink>()
//    
//    var handler: (Set<DeadlineLink>) -> Void
//    
//    init(item: Item, handler: @escaping (Set<DeadlineLink>) -> Void, selection: Set<DeadlineLink> = Set<DeadlineLink>()) {
//        self.item = item
//            _links = FetchRequest(
//                entity: DeadlineLink.entity(),
//                sortDescriptors: [
//                    NSSortDescriptor(keyPath: \DeadlineLink.placement, ascending: true)
//                ],
//                predicate: NSPredicate(format: "deadline == %@", item)
//            )
//        self.handler = handler
//        self.selection = selection
//    }
//    
//    var body: some View {
//        NavigationView {
//            List(links, id: \.self, selection: $selection) { link in
//                // Show link view
//                LinkView(name: link.name, url: link.url, imageURL: link.imageURL, done: link.done)
//            }
//            // Title
//            .navigationTitle("Manage links")
//            // Set edit mode
//            .toolbar{
//                EditButton()
//            }
//            .environment(\.editMode, $editMode)
//            // If done is pressed, close
//            .onChange(of: editMode) { _ in
//                // Return the selection
//                handler(selection)
//                dismiss()
//            }
//        }
//    }
//}
