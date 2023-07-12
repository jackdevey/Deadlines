////
////  NewDeadline.swift
////  Deadlines
////
////  Created by Jack Devey on 25/12/2022.
////
//
//import SwiftUI
//
//struct TodoManagerSheet: View {
//    
//    @Environment(\.dismiss) var dismiss
//    
//    // Mode relates to if the
//    // sheet is being used
//    // in the new or edit
//    // context
//    
//    enum Mode {
//        case new, edit
//    }
//    
//    var mode: Mode
//    
//    // The values being changed
//    // by the sheet
//    
//    @State var name: String = ""
//    @State var description: String = ""
//    @State var done: Bool = false
//    
//    // Handler function for
//    // on complete
//    
//    var handler: (String, String, Bool) -> Void
//    
//    // Keep error states
//    
//    @State private var errorEmptyName: Bool = false
//    
//    // Main body view
//    
//    var body: some View {
//        NavigationView {
//            List {
//                // Editor
//                Section {
//                    // Todo name
//                    TextField("Name", text: $name)
//                    // Todo description
//                    TextField("Description", text: $description)
//                }
//                // Done if is in edit mode
//                if mode == .edit {
//                    Section {
//                        Toggle("Done", isOn: $done)
//                    }
//                }
//            }
//            .listStyle(.grouped)
//            .navigationBarLargeTitle {
//                VStack(alignment: .leading) {
//                    TodoView(name: name, description: description, done: done)
//                }
//                .frame(width: .greedy)
//            }
//            // Set title
//            .navigationTitle(title)
//            // Toolbar items
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    // Cancel
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//                
//                ToolbarItem(placement: .confirmationAction) {
//                    // Confirm
//                    Button("Confirm") {
//                        guard name != "" else { return errorEmptyName.toggle() }
//                        // Run handler
//                        handler(name, description, done)
//                    }
//                }
//            }
//        }
//        // Alerts
//        .alert("Name cannot be empty", isPresented: $errorEmptyName) {}
//        // Set to medium first
//        .presentationDetents([.medium, .large])
//    }
//    
//    // Title
//    
//    var title: String {
//        switch(mode) {
//        case .new: return "New To do"
//        case .edit: return "Edit To do"
//        }
//    }
//    
//}
//
