//
//  DeadlineView.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import SwiftUI

struct DeadlineView: View {
    
    @StateObject var item: Item
    @State private var showingStatusPopover = false
    
    var body: some View {
        List {
            HStack {
                Text("Due date")
                Spacer()
                Text(item.date ?? Date.now, style: .date)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Status")
                Spacer()
                Image(systemName: item.getStatus().getIconName())
                    .foregroundColor(item.getStatus().getIconColor())
                Text(item.getStatus().getName())
                    .foregroundColor(.secondary)
            }.onPress {
                showingStatusPopover.toggle()
            }
            Section {
                // Todos
                NavigationLink(destination: DeadlineTodoView(deadline: item)) {
                    HStack {
                        Label("Checklist", systemImage: "checklist")
                        Spacer()
                        Text(String(item.checklistItemsCompletedPercentage) + "%")
                            .foregroundColor(.secondary)
                            .monospacedDigit()
                    }
                }
                // Notes
                NavigationLink(destination: NotesView(item: item)) {
                    Label("Notes", systemImage: "text.justify.leading")
                }
                // Links
                NavigationLink(destination: DeadlineLinkView(item: item)) {
                    Label("Links", systemImage: "link")
                }
                // Submitted
                Toggle(isOn: $item.submitted) {
                    Label("Submitted", systemImage: "paperplane")
                }
            }
        }
        .navigationTitle(item.name!)
        .sheet(isPresented: $showingStatusPopover) {
            VStack(alignment: .leading) {
                StatusView(status: item.getStatus(), showDescription: true)
                    .fill(alignment: .leading)
                    .padding(10)
                
            }.presentationDetents([.fraction(0.15)])
        }
    }
}
