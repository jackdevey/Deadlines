////
////  TodoView.swift
////  Deadlines
////
////  Created by Jack Devey on 02/01/2023.
////
//
//import Foundation
//import SwiftUI
//
//struct TodoView: View {
//    
//    var name: String?
//    var description: String?
//    var done: Bool
//    
//    var body: some View {
//        // Show each link as a link (with label)
//        HStack(alignment: .center) {
//            // Link image
//            ZStack {
//                RoundedRectangle(cornerRadius: 7)
//                    .fill(Color.secondarySystemFill)
//                    .frame(width: 40, height: 40)
//                Image(systemName: done ? "checkmark.circle.fill" : "circle")
//                    .foregroundColor(done ? .green : .secondaryLabel)
//            }
//            // Name & URL
//            VStack(alignment: .leading, spacing: 0) {
//                Text(niceifyString(name))
//                    .bold()
//                if description != nil && description != "" {
//                    Text(description ?? "")
//                        .foregroundColor(.secondaryLabel)
//                }
//            }
//            .padding([.leading], 5)
//        }
//        .padding(5)
//    }
//    
//    func niceifyString(_ value: String?, unnamed: String = "Unnamed") -> String {
//        return (value ?? "") == "" ? unnamed : value!
//    }
//    
//}
