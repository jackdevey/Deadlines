//
//  NewDeadline.swift
//  Deadlines
//
//  Created by Jack Devey on 25/12/2022.
//

import SwiftUI

struct NewDeadlineLinkSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var url: String = ""
    
    @State private var showURLInvalid: Bool = false
    @State private var showEmptyName: Bool = false
    var create: (DeadlineLink) -> ()
    
    func extractDomain(urlString: String) -> String {
        let url = URL(string: urlString)
        return url?.host(percentEncoded: true) ?? ""
    }
    
    var image: some View {
        AsyncImage(url: URL(string: "https://logo.clearbit.com/\(extractDomain(urlString: url))")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image(systemName: "link")
            }
            .frame(width: 40, height: 40)
            .backgroundFill(.secondarySystemFill)
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
    
    var preview: some View {
        HStack(alignment: .top) {
            // Show the link's image
            image
            // Title and URL
            VStack(alignment: .leading, spacing: 0) {
                // Deadline name
                Text(name)
                    .font(.headline)
                // Deadline due
                TextField("", text: $url, prompt: Text("Url"))
                    .textContentType(.URL)
                    .keyboardType(.URL)
                    .foregroundColor(.secondaryLabel)
            }
            .padding([.leading], 5)
        }
        .padding(5)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Preview") {
                    preview
                }
                
                Section {
                    // Deadline name
                    TextField("Title", text: $name)
                    // Deadline date (only allows future days)
                    HStack {
                        TextField("URL", text: $url)
                            .textContentType(.URL)
                            .keyboardType(.URL)
                        Spacer()
                        PasteButton(payloadType: String.self) { strings in
                            guard let first = strings.first else { return }
                            url = first
                        }
                        .labelStyle(.iconOnly)
                        .buttonBorderShape(.capsule)
                        .tint(.tertiarySystemBackground)
                    }
                }

            }
            
            .navigationTitle("New link")
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
                        // Name is empty
                        if name.isEmpty {
                            showEmptyName = true
                            return
                        }
                        // URL is wrong
                        if !url.isValidURL {
                            showURLInvalid = true
                            return
                        }
                        // New DeadlineLink object
                        let link = DeadlineLink(context: viewContext)
                        link.id = UUID()
                        link.name = name
                        link.url = URL(string: url)!
                        // Pass to DeadlineLinkView to manage
                        // placement & save
                        create(link)
                        dismiss()
                    } label: {
                        Text("Create")
                    }
                }
            }
            // If name is empty
            .alert("Name is empty", isPresented: $showEmptyName) {}
            // If URL is invalid
            .alert("URL is invalid", isPresented: $showURLInvalid) {}
        }
    }
}

extension String {

    // Check if its a URL
    var isValidURL: Bool {
        guard !contains("..") else { return false }
                                                                                                                        
        let head     = "((http|https)://)?([(w|W)]{3}+\\.)?"
        let tail     = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
        let urlRegEx = head+"+(.)+"+tail
                                                                                                                        
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)

        return urlTest.evaluate(with: trimmingCharacters(in: .whitespaces))
    }

}
