//
//  NewDeadline.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct NewDeadline: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var desc: String = "Anything you need to remember related to this deadline can go here"
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextEditor(text: $desc)
                }
                
                Section {
                    TextEditor(text: $desc)
                        .lineLimit(4)
                } header: {
                    Text("Notes")
                }
            }
            .navigationTitle("New deadline")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(id: "cancel", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(id: "create", placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Create")
                    }
                }
            }
        }
    }
}
