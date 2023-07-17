////
////  DeadlineView.swift
////  Deadlines
////
////  Created by Jack Devey on 02/01/2023.
////
//
import SwiftUI


struct DeadlineView: View {
    
    @StateObject var deadline: Deadline
    
    @State private var isShowingEditDeadlineSheet: Bool = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    ProgressView(deadline.progress, value: deadline.percentCompleted, total: 1)
                    Text(deadline.progressDescription)
                        .font(.footnote)
                }
                Button {
                    isShowingEditDeadlineSheet = true
                } label: {
                    HStack {
                        Label("Edit Details", systemImage: "slider.horizontal.2.square")
                        Spacer()
                        Image(systemName: "chevron.up.square")
                            .imageScale(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                
                // Checklist
                NavigationLink {
                    DeadlineTodoView(deadline: deadline)
                } label: {
                    Label {
                        Text("Checklist")
                    } icon: {
                        Image(systemName: "checklist")
                            .imageScale(.medium)
                    }
                    .foregroundStyle(.primary)
                }
                
                // Links
                NavigationLink {
                    Text("todo")
                } label: {
                    Label {
                        Text("Links")
                    } icon: {
                        Image(systemName: "link")
                            .imageScale(.medium)
                    }
                    .foregroundStyle(.primary)
                }
            }
            
            Section {
                // isSubmitted
                Toggle(isOn: $deadline.isSubmitted) {
                    Label {
                        Text("Submitted")
                    } icon: {
                        Image(systemName: "paperplane")
                            .imageScale(.medium)
                    }
                    .foregroundStyle(.blue)
                }
                // isUrgent
                Toggle(isOn: $deadline.isUrgent) {
                    Label {
                        Text("Urgent")
                    } icon: {
                        Image(systemName: "exclamationmark")
                            .imageScale(.medium)
                    }
                    .foregroundStyle(.red)
                }.onChange(of: deadline.isUrgent) {
                    try? deadline.context?.save()
                }
            } header: {
                Text("Flags")
            } footer: {
                Text("Flags can be used to help categorise the state of Deadlines as they progress, they are often automatically assigned by the App however can be manually overidden here.")
            }
        }
        .navigationTitle(deadline.name)
        .sheet(isPresented: $isShowingEditDeadlineSheet) {
            NewEditDeadlineView(
                new: false,
                title: "Edit Details",
                name: deadline.name,
                date: deadline.due,
                colorId: deadline.colorId,
                iconName: deadline.icon,
                cancelHandler: {
                    // Close the view
                    isShowingEditDeadlineSheet = false
                },
                confirmHandler: { name, date, colorId, iconName in
                    // Make a new deadline
                    deadline.name = name
                    deadline.due = date
                    deadline.colorId = colorId
                    deadline.icon = iconName
                    // Close the view
                    isShowingEditDeadlineSheet = false
                }
            )
        }
    }
    
}

//
//struct DeadlineView: View {
//    
//    @StateObject var item: Item
//    
//    @State var showChangeIconSheet = false
//        
//    var body: some View {
//        
//        List {
//            Section {
//                // Due date
//                HStack {
//                    Text("Due Date")
//                        .font(.headline)
//                    Spacer()
//                    Text(item.date!, format: .dateTime)
//                        .foregroundColor(.secondaryLabel)
//                }
//                .padding(5)
//                // Time left
//                HStack {
//                    if item.daysDiff >= 0 {
//                        Text("Days Remaining")
//                            .font(.headline)
//                    } else {
//                        Text("Days Past")
//                            .font(.headline)
//                    }
//                    Spacer()
//                    // dont like this is really dirty
//                    Text(String(Int(sqrt(Double(item.daysDiff*item.daysDiff)))))
//                        .foregroundColor(.secondaryLabel)
//                }
//                .padding(5)
//                // Status
//                HStack {
//                    Text("Status")
//                        .font(.headline)
//                    Spacer()
//                    HStack {
//                        Image(systemName: item.status.iconName)
//                            .imageScale(.small)
//                            .foregroundColor(item.status.iconColor)
//                        Text(item.status.name)
//                            .foregroundColor(.secondaryLabel)
//                    }
//                }
//                .padding(5)
//            }
//            // Deadline type
//            Section {
//                // Checklist
//                DeadlineTodoView(item: item)
//                // Links
//                DeadlineLinkView(item: item)
////                // Plan
////                NavigationLink {
////                    DeadlineLinkView(item: item)
////                } label: {
////                    NiceIconLabel(text: "Work Plan", color: .systemTeal, iconName: "book.closed.fill")
////                }
////                // Target
////                NavigationLink {
////                    DeadlineLinkView(item: item)
////                } label: {
////                    NiceIconLabel(text: "Target", color: .green, iconName: "target")
////                }
////                // Documents
////                NavigationLink {
////                    NotesView(item: item)
////                } label: {
////                    NiceIconLabel(text: "Documents", color: .indigo, iconName: "folder.fill")
////                }
//                // Tags
//                NavigationLink {
//                    DeadlineTagsView(deadline: item)
//                } label: {
//                    NiceIconLabel(text: "Tags", color: .indigo, iconName: "number")
//                }
//                // Notes
//                NavigationLink {
//                    NotesView(item: item)
//                } label: {
//                    NiceIconLabel(text: "Notes", color: .orange, iconName: "note")
//                }
//            }
//            
//            Section {
//                // Change Icon
//                MYNavigationLink {
//                    // Show settings view
//                    showChangeIconSheet = true
//                } label: {
//                    NiceIconLabel(text: "Edit Details", color: item.colour, iconName: item.iconName ?? "app")
//                }
//                // Settings
//                NavigationLink {
//                    // Show settings view
//                    DeadlineSettingsView(deadline: item)
//                } label: {
//                    NiceIconLabel(text: "Settings", color: .gray, iconName: "gearshape.fill")
//                }
//            }
//        
//        }
//        // Allow deadline title to be edited
//        .navigationTitle(item.name!)
//        // Change Icon Sheet
//        .sheet(isPresented: $showChangeIconSheet) {
//            NewEditDeadlineView(
//                new: false,
//                title: "Edit Details",
//                name: item.name ?? "",
//                date: item.date ?? Date.now,
//                color: item.color,
//                iconName: item.iconName ?? "bookmark.fill",
//                cancelHandler: {
//                    // Close the view
//                    showChangeIconSheet = false
//                },
//                confirmHandler: { name, date, color, iconName in
//                    // Make a new deadline
//                    item.name = name
//                    item.date = date
//                    item.color = color
//                    item.iconName = iconName
//                    // Close the view
//                    showChangeIconSheet = false
//                }
//            )
//        }
//    }
////            List {
////                HStack {
////                    Text("Due date")
////                    Spacer()
////                    Text(item.date ?? Date.now, style: .date)
////                        .foregroundColor(.secondary)
////                }
////                HStack {
////                    Text("Status")
////                    Spacer()
////                    Image(systemName: item.getStatus().getIconName())
////                        .foregroundColor(item.getStatus().getIconColor())
////                    Text(item.getStatus().getName())
////                        .foregroundColor(.secondary)
////                }
////                Section {
////                    // Todos
////                    NavigationLink(destination: DeadlineTodoView(deadline: item)) {
////                        HStack {
////                            Label("Checklist", systemImage: "checklist")
////                            Spacer()
////                            Text(String(item.checklistItemsCompletedPercentage) + "%")
////                                .foregroundColor(.secondary)
////                                .monospacedDigit()
////                        }
////                    }
////                    // Notes
////                    NavigationLink(destination: NotesView(item: item)) {
////                        Label("Notes", systemImage: "text.justify.leading")
////                    }
////                    // Links
////                    NavigationLink(destination: DeadlineLinkView(item: item)) {
////                        Label("Links", systemImage: "link")
////                    }
////                    // Submitted
////                    Toggle(isOn: $item.submitted) {
////                        Label("Submitted", systemImage: "paperplane")
////                    }
////                }
////            }
////        }
//    
//}
//
//@ViewBuilder
//func NiceIconLabelFlat(text: String, color: Color, iconName: String) -> some View {
//    NiceIconLabel(
//        text: Text(text)
//            .font(.headline),
//        background: RoundedRectangle(cornerRadius: 5)
//            .fill(color)
//            .frame(width: 30, height: 30),
//        foreground: Image(systemName: iconName)
//            .imageScale(.small)
//            .foregroundColor(.white)
//    )
//}
//
//@ViewBuilder
//func NiceIconLabel(text: String, color: Color, iconName: String) -> some View {
//    NiceIconLabel(
//        text: Text(text)
//            .font(.headline),
//        background: RoundedRectangle(cornerRadius: 5)
//            .fill(color)
//            .frame(width: 30, height: 30),
//        foreground: Image(systemName: iconName)
//            .imageScale(.small)
//            .foregroundColor(.white)
//    )
//}
//
//@ViewBuilder
//func NiceIconLabel(text: String, material: Material, iconName: String) -> some View {
//    NiceIconLabel(
//        text: Text(text)
//            .font(.headline),
//        background: RoundedRectangle(cornerRadius: 5)
//            .background(material)
//            .frame(width: 30, height: 30),
//        foreground: Image(systemName: iconName)
//            .imageScale(.small)
//            .foregroundColor(.white)
//    )
//}
//
//@ViewBuilder
//func NiceIconLabel(text: some View, background: some View, foreground: some View, padding: CGFloat = 5) -> some View {
//    // Show label
//    Label {
//        text
//    } icon: {
//        ZStack {
//            background
//            foreground
//        }
//    }
//    .padding(padding)
//}
//
//                         extension Binding {
//                              func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
//                                 Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
//                             }
//                         }
