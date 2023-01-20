//
//  LinkRowView.swift
//  Deadlines
//
//  Created by Jack Devey on 20/01/2023.
//

import SwiftUI

struct LinkRowView: View {
    
    // Params
    var link: DeadlineLink
    
    // Pasteboard
    private let pasteboard = UIPasteboard.general
    
    var body: some View {
        // View body
        HStack(alignment: .top) {
            image
            VStack(alignment: .leading, spacing: 0) {
                name
                url
            }
            .padding([.leading], 5)
        }
        .padding(5)
        // Menu
        .contextMenu {
            Section("") {
                copyLinkButton
            }
        }
    }
    
    var image: some View {
        // Link image
        AsyncImage(url: link.imageURL) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            // Placeholder
            Image(systemName: "link")
        }
        .frame(width: 40, height: 40)
        .backgroundFill(.secondarySystemFill)
        .clipShape(RoundedRectangle(cornerRadius: 7))
    }
    
    var name: some View {
        // Link name
        Text(link.name ?? "Unknown")
            .font(.headline)
    }
    
    var url: some View {
        // Link url
        Text(link.url?.absoluteString ?? "Unknown")
            .lineLimit(1)
            .foregroundColor(.secondaryLabel)
    }
    
    var copyLinkButton: some View {
        Button {
            pasteboard.string = link.url?.absoluteString ?? ""
        } label: {
            Label("Copy link", systemImage: "doc.on.doc")
        }
    }
    
}
