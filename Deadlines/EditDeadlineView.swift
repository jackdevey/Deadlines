//
//  EditDeadlineView.swift
//  Deadlines
//
//  Created by Jack Devey on 13/01/2023.
//

import SwiftUI

struct EditDeadlineView: View {
    
    // The deadline attributes to edit
    @State var name: String = ""
    @State var date: Date = Date.now
    @State var color: Int16 = 0
    @State var iconName: String = "app"
    @State var tags: [Tag] = []
    
    // Convey cancel and continue events
    // to parent
    var cancelHandler: () -> Void
    var confirmHandler: (String, Date, Int16, String, [Tag]) -> Void
    
    // Deadline customisations arrays
    let dc = DeadlineCustomisations()
    
    // Global tags list
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tag.timestamp, ascending: false)],
        animation: .default)
    private var globalTags: FetchedResults<Tag>
    
    init(
        deadline: Item? = nil, // Can be null for when new deadline
        cancelHandler: @escaping () -> Void,
        confirmHandler: @escaping (String, Date, Int16, String, [Tag]) -> Void
    ) {
        // Just set all boring stuff
        self.cancelHandler = cancelHandler
        self.confirmHandler = confirmHandler
        // Take copies of deadline attributes
        self.name = deadline?.name ?? ""
        self.date = deadline?.date ?? Date.now
        self.color = deadline?.color ?? 0
        self.iconName = deadline?.iconName ?? ""
        self.tags = deadline?.tags?.array as? [Tag] ?? []
    }
    
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
                    DatePicker("Date", selection: $date, in: Date.now..., displayedComponents: .date)
                }
                Section {
                    dc.ColorPicker(selection: $color)
                }
                Section {
                    dc.IconPicker(colorId: color, selection: $iconName)
                }
                // Tag picker
                Section {
                    ForEach(globalTags.indices, id: \.self) { idx in
                        TagItem(tag: globalTags[idx], index: idx)
                    }
                }
            }
            .toolbar {
                // Cancel button that calls cancelHandler
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        cancelHandler()
                    }
                }
                // Confirm button that calls confirmHandler
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        confirmHandler(name, date, color, iconName, tags)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func Preview() -> some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(dc.colors[Int(self.color)])
                    .frame(width: 40, height: 40)
                Image(systemName: self.iconName)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                // Deadline name
                Text(self.name == "" ? "Unnamed" : self.name)
                    .font(.headline)
                // Deadline due
                Text(self.date, style: .date)
                    .foregroundColor(.secondary)
                // Deadline tags
                if self.tags.count != 0 {
                    Text(self.tags.map{"#\($0.text ?? "Unknown")"}.joined(separator: " "))
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.systemIndigo)
                        .bold()
                }
            }
            .padding([.leading], 5)
        }
        .padding(5)
    }
    
    @ViewBuilder
    func TagItem(tag: Tag, index: Int) -> some View {
        Button {
            if tags.contains(tag) {
                tags.remove(at: index)
            } else {
                tags.append(tag)
            }
        } label: {
            HStack {
                tag.LabelView()
                Spacer()
                if tags.contains(tag) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                }
            }
            .tint(.primary)
        }
    }
}
