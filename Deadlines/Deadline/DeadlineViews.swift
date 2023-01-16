//
//  DeadlineViews.swift
//  Deadlines
//
//  Created by Jack Devey on 12/01/2023.
//

import Foundation
import SwiftUI

extension Item {
    
    @ViewBuilder
    func ListView() -> some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(self.colour)
                    .frame(width: 40, height: 40)
                Image(systemName: self.iconName ?? "app")
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                // Deadline name
                Text(self.name ?? "Unknown")
                    .font(.headline)
                // Deadline due
                Text(self.date ?? Date.now, style: .date)
                    .foregroundColor(.secondary)
                // Deadline tags
                if self.tags?.count != 0 {
                    Text(self.tagNames.joined(separator: " "))
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.systemIndigo)
                        .bold()
                }
            }
            .padding([.leading], 5)
        }
        .padding(5)
    }

}
    

