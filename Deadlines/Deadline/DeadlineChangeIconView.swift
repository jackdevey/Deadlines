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
    
    let dc = DLCustomisation()
    
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
                    //dc.ColorPicker(selection: $deadline.color)
                    
                }
                Section() {
                    // Show all available icons
                    //dc.IconPicker(colorId: deadline.color, selection: $deadline.iconName.toUnwrapped(defaultValue: "app"))
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
    
   
}
