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
    @State var colorId: Int = 10
    @State var iconName: String = "bookmark.fill"
    @State var isSubmitted: Bool = false
    @State var isUrgent: Bool = false
    
    // Convey cancel and continue events
    // to parent
    var cancelHandler: () -> Void
    var confirmHandler: (String, Date, Int, String, Bool, Bool) -> Void
    
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
                    DLCustomisation.ColorPicker(selection: $colorId)
                }
                Section {
                    DLCustomisation.IconPicker(selection: $iconName, colorId: colorId)
                }
                Section {
                    // isSubmitted
                    Toggle(isOn: $isSubmitted) {
                        Label {
                            Text("Submitted")
                        } icon: {
                            Image(systemName: "paperplane")
                                .imageScale(.medium)
                        }
                        .foregroundStyle(.blue)
                    }
                    // isUrgent
                    Toggle(isOn: $isUrgent) {
                        Label {
                            Text("Urgent")
                        } icon: {
                            Image(systemName: "exclamationmark")
                                .imageScale(.medium)
                        }
                        .foregroundStyle(.red)
                    }
                } header: {
                    Text("Flags")
                } footer: {
                    Text("Flags can be used to help categorise the state of Deadlines as they progress, they are often automatically assigned by the App however can be manually overidden here.")
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
                        confirmHandler(name, date, colorId, iconName, isSubmitted, isUrgent)
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
        HStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(DLCustomisation.colors[Int(self.colorId)].gradient)
                    .frame(width: 35, height: 35)
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
    }

}
