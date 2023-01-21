//
//  NewDeadline.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct LinkManagerSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    // Mode relates to if the
    // sheet is being used
    // in the new or edit
    // context
    
    enum Mode {
        case new, edit
    }
    
    var mode: Mode
    
    // The values being changed
    // by the sheet
    
    @State var name: String = ""
    @State var url: String = ""
    
    // Handler function for
    // on complete
    
    var handler: (String, URL) -> Void
    
    // Keep error states
    
    @State private var errorEmptyName: Bool = false
    @State private var errorBadURL: Bool = false
    
    // Main body view
    
    var body: some View {
        NavigationView {
            Form {
                // Preview at top
                Section("Preview") {
                    LinkView(name: name, url: URL(string: url), imageURL: imageURL)
                }
                // Editor
                Section {
                    // Link name
                    TextField("Name", text: $name)
                    // Link URL
                    urlField
                }
            }
            // Set title
            .navigationTitle(title)
            // Toolbar items
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    // Cancel
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    // Confirm
                    Button("Confirm") {
                        guard name != "" else { return errorEmptyName.toggle() }
                        guard url.isValidURL else { return errorBadURL.toggle() }
                        // Run handler
                        handler(name, URL(string: url)!)
                    }
                }
            }
        }
        // Alerts
        .alert("Name cannot be empty", isPresented: $errorEmptyName) {}
        .alert("URL is invalid", isPresented: $errorBadURL) {}
        // Set to medium first
        .presentationDetents([.medium, .large])
    }
    
    // Title
    
    var title: String {
        switch(mode) {
        case .new: return "New link"
        case .edit: return "Edit link"
        }
    }
    
    // Image url
    
    var imageURL: URL {
        let url = URL(string: url)
        let domain = url?.host ?? ""
        return URL(string: "https://logo.clearbit.com/\(domain)")!
    }
    
    // Link url field with
    // paste button
    
    var urlField: some View {
        HStack {
            // Normal TextField
            TextField("URL", text: $url)
                .textContentType(.URL)
                .keyboardType(.URL)
            Spacer()
            // Paste button
            PasteButton(payloadType: String.self) { strings in
                // Get first url
                guard let first = strings.first else { return }
                url = first
            }
            .labelStyle(.iconOnly)
            .buttonBorderShape(.capsule)
            .tint(.tertiarySystemBackground)
        }
    }
    
}

extension String {

    // Check if its a URL
    var isValidURL: Bool {
        guard !contains("..") else { return false }
                                                                                                                        
        let head     = "((http|https)://)([(w|W)]{3}+\\.)?"
        let tail     = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
        let urlRegEx = head+"+(.)+"+tail
                                                                                                                        
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)

        return urlTest.evaluate(with: trimmingCharacters(in: .whitespaces))
    }

}

extension DeadlineLink {
    
    var domain: String {
        url?.host(percentEncoded: true) ?? ""
    }
    
    var imageURL: URL {
        URL(string: "https://logo.clearbit.com/\(domain)")!
    }
    
}
