////
////  DeadlineViews.swift
////  Deadlines
////
////  Created by Jack Devey on 12/01/2023.
////
//
//import Foundation
//import SwiftUI
//

import SwiftUI

extension Deadline {
    
    @ViewBuilder
    func ListView() -> some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.gray.gradient)
                    .frame(width: 40, height: 40)
                Image(systemName: self.icon)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                // Deadline name
                Text(self.name)
                    .font(.headline)
                // Deadline due
                Text(self.due.formatted(date: .abbreviated, time: .shortened))
                    .foregroundColor(.secondary)
//                // Deadline tags
//                if self.tags?.count != 0 {
//                    Text(self.tagNames.joined(separator: " "))
//                        .font(.system(.subheadline, design: .rounded))
//                        .foregroundColor(.systemIndigo)
//                        .bold()
//                }
            }
            .padding([.leading], 5)
        }
        .padding(5)
//        .contextMenu {
//            Button {
//                self.submitted = true
//            } label: {
//                Label("Submit", systemImage: "paperplane.fill")
//            }
//        }

    }

}
//    
//
