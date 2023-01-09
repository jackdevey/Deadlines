//
//  DeadlineView.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import SwiftUI

struct DeadlineView: View {
    
    @StateObject var item: Item
        
    var body: some View {
        
        List {
            Section {
                // Due date
                HStack {
                    Text("Due Date")
                        .font(.headline)
                    Spacer()
                    Text(item.date!, format: .dateTime)
                        .foregroundColor(.secondaryLabel)
                }
                .padding(5)
                // Time left
                HStack {
                    Text("Days Remaining")
                        .font(.headline)
                    Spacer()
                    Text(item.daysUntil)
                        .foregroundColor(.secondaryLabel)
                }
                .padding(5)
                // Status
                HStack {
                    Text("Status")
                        .font(.headline)
                    Spacer()
                    HStack {
                        Image(systemName: item.getStatus().getIconName())
                            .imageScale(.small)
                            .foregroundColor(item.getStatus().getIconColor())
                        Text(item.getStatus().getName())
                            .foregroundColor(.secondaryLabel)
                    }
                }
                .padding(5)
            }
            // Deadline type
            Section {
                // Checklist
                NavigationLink {
                    DeadlineTodoView(deadline: item)
                } label: {
                    HStack {
                        // Show status icon
                        NiceIconLabel(text: "Checklist", color: .blue, iconName: "checklist")
                        // Space apart
                        Spacer()
                        // Show status
                        Text("\(item.checklistItemsCompletedPercentage)%")
                            .monospacedDigit()
                            .foregroundColor(.secondaryLabel)
                    }
                }
                // Plan
                NavigationLink {
                    DeadlineLinkView(item: item)
                } label: {
                    NiceIconLabel(text: "Work Plan", color: .systemTeal, iconName: "book.closed.fill")
                }
                // Target
                NavigationLink {
                    DeadlineLinkView(item: item)
                } label: {
                    NiceIconLabel(text: "Target", color: .green, iconName: "target")
                }
                // Documents
                NavigationLink {
                    NotesView(item: item)
                } label: {
                    NiceIconLabel(text: "Documents", color: .indigo, iconName: "folder.fill")
                }
                // Reminders
                NavigationLink {
                    NotesView(item: item)
                } label: {
                    NiceIconLabel(text: "Reminders", color: .red, iconName: "bell.badge.fill")
                }
                // Tags
                NavigationLink {
                    NotesView(item: item)
                } label: {
                    NiceIconLabel(text: "Tags", color: .mint, iconName: "tag.fill")
                }
                // Links
                NavigationLink {
                    DeadlineLinkView(item: item)
                } label: {
                    NiceIconLabel(text: "Links", color: .purple, iconName: "link")
                }
                // Notes
                NavigationLink {
                    NotesView(item: item)
                } label: {
                    NiceIconLabel(text: "Notes", color: .orange, iconName: "note")
                }
            }
            
            Section {
                // Choose Icon
                NavigationLink {
                    // Show settings view
                    DeadlineSettingsView(deadline: item)
                } label: {
                    NiceIconLabel(text: "Settings", color: .gray, iconName: "gearshape.fill")
                }
            }
        
        }
        // Allow deadline title to be edited
        .navigationTitle($item.name.toUnwrapped(defaultValue: ""))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)

         // Add toolbar items
        .toolbar {
            // Icon and title
            ToolbarItem(id: "title", placement: .principal) {
                HStack {
                    // Show deadline icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(item.getColour().gradient)
                            .frame(width: 25, height: 25)
                        Image(systemName: item.getIconName())
                            .imageScale(.small)
                            .foregroundColor(.white)
                    }
                    // Show deadline name
                    VStack(alignment: .leading) {
                        Text(item.name!)
                            .bold()
                    }
                    .padding([.leading], 4)
                }
            }
            // Add title menu options
            ToolbarTitleMenu {
                
                // Rename the deadline
                RenameButton()
            }
        }
    }
//            List {
//                HStack {
//                    Text("Due date")
//                    Spacer()
//                    Text(item.date ?? Date.now, style: .date)
//                        .foregroundColor(.secondary)
//                }
//                HStack {
//                    Text("Status")
//                    Spacer()
//                    Image(systemName: item.getStatus().getIconName())
//                        .foregroundColor(item.getStatus().getIconColor())
//                    Text(item.getStatus().getName())
//                        .foregroundColor(.secondary)
//                }
//                Section {
//                    // Todos
//                    NavigationLink(destination: DeadlineTodoView(deadline: item)) {
//                        HStack {
//                            Label("Checklist", systemImage: "checklist")
//                            Spacer()
//                            Text(String(item.checklistItemsCompletedPercentage) + "%")
//                                .foregroundColor(.secondary)
//                                .monospacedDigit()
//                        }
//                    }
//                    // Notes
//                    NavigationLink(destination: NotesView(item: item)) {
//                        Label("Notes", systemImage: "text.justify.leading")
//                    }
//                    // Links
//                    NavigationLink(destination: DeadlineLinkView(item: item)) {
//                        Label("Links", systemImage: "link")
//                    }
//                    // Submitted
//                    Toggle(isOn: $item.submitted) {
//                        Label("Submitted", systemImage: "paperplane")
//                    }
//                }
//            }
//        }
    
}

@ViewBuilder
func NiceIconLabel(text: String, color: Color, iconName: String) -> some View {
    // Show label
    Label {
        Text(text)
            .font(.headline)
    } icon: {
        // Icon frame
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 5)
                .fill(color.gradient)
                .frame(width: 30, height: 30)
            // Icon
            Image(systemName: iconName)
                .imageScale(.small)
                .foregroundColor(.white)
        }
    }
    .padding(5)
}

                         extension Binding {
                              func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
                                 Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
                             }
                         }
