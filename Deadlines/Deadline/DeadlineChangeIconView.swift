//
//  DeadlineChangeIconView.swift
//  Deadlines
//
//  Created by Jack Devey on 12/01/2023.
//

import SwiftUI

struct DeadlineChangeIconView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var deadline: Item
    
    let deadlineCustomisations = DeadlineCustomisations()
    
    let columns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Preview")) {
                    deadline.RowView()
                }
                Section() {
                    // Show all available colours
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0...(deadlineCustomisations.colours.endIndex - 1), id: \.self) { idx in
                            ColorPicker(idx: idx)
                        }
                    }
                    
                }
                Section() {
                    // Show all available icons
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(deadlineCustomisations.icons, id: \.self) { icon in
                            IconPicker(icon: icon)
                        }
                    }
                }
            }
            // Set title
            .navigationTitle("Change Icon")
            .navigationBarTitleDisplayMode(.inline)
            // Show toolbar
            .toolbar {
                // Cancel
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        // Close
                        dismiss()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func ColorPicker(idx: Int) -> some View {
        ZStack {
            Circle()
                .fill(deadlineCustomisations.colours[idx])
                .frame(width: 40, height: 40)
            if deadlineCustomisations.colours[Int(deadline.color)] == deadlineCustomisations.colours[idx] {
                Image(systemName: "checkmark")
            }
        }
        .onPress {
            deadline.color = Int16(idx)
        }
    }
    
    @ViewBuilder
    func IconPicker(icon: String) -> some View {
        ZStack {
            if deadline.iconName == icon {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 40, height: 40)
            } else {
                Circle()
                    .fill(Color.darkGray)
                    .frame(width: 40, height: 40)
            }
            Image(systemName: icon)
        }
        .onPress {
            deadline.iconName = icon
        }
    }
}
