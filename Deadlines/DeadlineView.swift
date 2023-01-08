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
            HStack {
                // Show status icon
                ZStack {
                    Circle()
                        .fill(item.getStatus().getIconColor())
                        .frame(width: 26, height: 26)
                    Image(systemName: item.getStatus().getIconName())
                        .imageScale(.small)
                        .foregroundColor(.white)
                }
                // Text
                VStack(alignment: .leading) {
                    Text(item.getStatus().getName())
                        .bold()
                    Text(item.getStatus().getDescription())
                        .foregroundColor(.secondary)
                }
                // Add padding to left side
                .padding([.leading], 5)
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
                Section {
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
                    }
                }
                Button("Hi") {
                    
                }
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

                         extension Binding {
                              func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
                                 Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
                             }
                         }
