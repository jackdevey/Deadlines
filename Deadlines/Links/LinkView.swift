//
//  LinkView.swift
//  Deadlines
//
//  Created by Jack Devey on 21/01/2023.
//

import SwiftUI

struct LinkView: View {
    
    var name: String?
    var url: URL?
    var imageURL: URL?
    var done: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            // Link image
            AsyncImage(url: imageURL) { image in
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
            
            // Name & URL
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    // Link name
                    Text(niceifyString(name))
                        .font(.headline)
                    // Seen icon
                    if done {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                            .imageScale(.small)
                    }
                }
                // Link URL
                Text(niceifyString(url?.absoluteString, unnamed: "No URL"))
                    .lineLimit(1)
                    .foregroundColor(.secondaryLabel)
            }
            .padding([.leading], 5)
        }
        .padding(5)
    }
    
    func niceifyString(_ value: String?, unnamed: String = "Unnamed") -> String {
        return (value ?? "") == "" ? unnamed : value!
    }
}
