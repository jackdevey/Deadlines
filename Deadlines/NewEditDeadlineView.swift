//
//  EditDeadlineView.swift
//  Deadlines
//
//  Created by Jack Devey on 13/01/2023.
//

import SwiftUI

struct NewEditDeadlineView: View {
    
    // If is new or editing
    var new: Bool = true
    
    // Get title to show
    var title: String = "New Deadline"
    
    // Show cancel or not?
    var showCancel: Bool = true
    
    // The deadline attributes to edit
    @State var name: String = ""
    @State var date: Date = Date.now
    @State var color: Int16 = 10
    @State var iconName: String = "bookmark.fill"
    
    // Convey cancel and continue events
    // to parent
    var cancelHandler: () -> Void
    var confirmHandler: (String, Date, Int16, String) -> Void
    
    // Deadline customisations arrays
    let dc = DLCustomisation()
    
//    // Global tags list
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Tag.timestamp, ascending: false)],
//        animation: .default)
//    private var globalTags: FetchedResults<Tag>
    
    var body: some View {
        NavigationStack {
            List {
                // Deadline preview
                Section(header: Text("Preview")) {
                    Preview()
                }
                Section {
                    // Deadline name
                    TextField("Name", text: $name)
                    // Deadline date (only allows future days)
                    DatePicker("Date", selection: $date)
                }
                Section {
                    dc.ColorPicker(selection: $color)
                }
                Section {
                    dc.IconPicker(selection: $iconName, colorId: color)
                }
            }
            .toolbar {
                // Cancel button that calls cancelHandler
                if showCancel {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            cancelHandler()
                        }
                    }
                }
                // Confirm button that calls confirmHandler
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        // If name is empty
                        guard self.name != "" else {
                            Alert(title: Text("Deadline must have a title"))
                            return
                        }
                        // If date is in future
                        guard !new || (self.date >= Date.now) else {
                            Alert(title: Text("Deadline must be due in the future"))
                            return
                        }
                        confirmHandler(name, date, color, iconName)
                    }
                }
            }
            // Set navigation title
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    @ViewBuilder
    func Preview() -> some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(dc.colors[Int(self.color)].gradient)
                    .frame(width: 40, height: 40)
                Image(systemName: self.iconName)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading, spacing: 0) {
                // Deadline name
                TextField("", text: $name, prompt: Text("Unnamed"))
                    .font(.headline)
                // Deadline due
                Text(self.date, style: .date)
                    .foregroundColor(.secondary)
            }
            .padding([.leading], 5)
        }
        .padding(5)
    }

}
