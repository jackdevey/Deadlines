//
//  DeadlineCustomisations.swift
//  Deadlines
//
//  Created by Jack Devey on 13/01/2023.
//

import Foundation
import SwiftUI

struct DeadlineCustomisations {
    
    // Icons
    let icons: [String] = [
        "bookmark.fill", "mappin", "graduationcap.fill", "dice.fill", "figure.dance",
        "key.horizontal.fill", "mountain.2.fill", "car.rear.fill", "tree.fill", "fish.fill",
        "mug.fill", "case.fill", "lightbulb.fill", "house.fill", "doc.fill", "person.fill"
    ]
    
    // colours
    let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .indigo, .pink, .purple, .brown, .darkGray]
    
    @ViewBuilder
    func ColorPicker(
        selection: Binding<Int16>,
        columns: [GridItem] = [GridItem(.adaptive(minimum: 40))]
    ) -> some View {
        // Show all available colours
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(colors.indices, id: \.self) { idx in
                ZStack {
                    Circle()
                        .fill(colors[idx])
                        .frame(width: 40, height: 40)
                    if colors[Int(selection.wrappedValue)] == colors[idx] {
                        Image(systemName: "checkmark")
                    }
                }
                .onPress {
                    selection.wrappedValue = Int16(idx)
                }
            }
        }
    }
    
    @ViewBuilder
    func IconPicker(
        colorId: Int16,
        selection: Binding<String>,
        columns: [GridItem] = [GridItem(.adaptive(minimum: 40))]
    ) -> some View {
        // Show all available colours
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(icons, id: \.self) { icon in
                ZStack {
                    Circle()
                        .fill(selection.wrappedValue == icon ? colors[Int(colorId)] : Color.darkGray)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                }
                .onPress {
                    selection.wrappedValue = icon
                }
            }
        }
    }
}
