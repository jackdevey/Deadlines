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
    var create: (DeadlineLink) -> ()
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("URL", text: $url)
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
                        let link = DeadlineLink(context: viewContext)
                        link.id = UUID()
                        link.name = name
                        
                        // URL is wrong
                        if !url.isValidURL {
                            showURLInvalid = true
                            return
                        }
                        
                        link.url = URL(string: url)!
                        
                        create(link)
                        dismiss()
                    } label: {
                        Text("Create")
                    }
                }
            }
            .alert("URL is invalid", isPresented: $showURLInvalid) {
                
            }
        }
    }
}

                                                                                                                    extension String {

                                                                                                                        var isValidURL: Bool {
                                                                                                                            guard !contains("..") else { return false }
                                                                                                                        
                                                                                                                            let head     = "((http|https)://)?([(w|W)]{3}+\\.)?"
                                                                                                                            let tail     = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
                                                                                                                            let urlRegEx = head+"+(.)+"+tail
                                                                                                                        
                                                                                                                            let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)

                                                                                                                            return urlTest.evaluate(with: trimmingCharacters(in: .whitespaces))
                                                                                                                        }

                                                                                                                    }
