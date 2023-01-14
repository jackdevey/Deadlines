//
//  DeadlineCustomisations.swift
//  Deadlines
//
//  Created by Jack Devey on 13/01/2023.
//

import Foundation
import SwiftUI

/// Provides methods to aid in the customisation of Deadline objects.
/// Holds the possible colors and icons for Deadlines in `colors` and
/// `icons` lists respectively.
/// Has UI methods to render `ColorPicker` and `IconPicker`
/// elements, that can operate directly on the `Item` object for simplicity.
struct DLCustomisation {
    
    /// List of colors as used in the `ColorPicker`
    let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .indigo, .pink, .purple, .brown, .darkGray]
    
    /// Gets the associated color from the `colorId` provided
    /// > Might return nil if out of bounds
    /// - Parameters:
    ///     - colorId: `Int16` The colorId for the color
    /// - Returns: `Color?` The associated color or nil
    func getColor(colorId: Int16) -> Color? {
        if Int(colorId) < colors.count - 1 {
            return colors[Int(colorId)]
        } else {
            return nil
        }
    }

    /// Produces a color picker UI, saving the selection within the `selection` parameter
    /// as a colorId in the bounds of the `colors` list.
    /// ```
    /// ColorPicker(selection: $colorId)
    /// ```
    /// > The `selection` parameter holds the colorId in Int16 value, not the `Color` value
    /// > itself. Use `getColor(colorId: Int16)` to convert this to a `Color` type.
    /// - Parameters:
    ///     - selection: `Binding<Int16>` The binding to store the selection to
    ///     - columns: `[GridItem]` The columns to use for the `GridView`
    @ViewBuilder
    func ColorPicker(
        selection: Binding<Int16>,
        columns: [GridItem] = [GridItem(.adaptive(minimum: 40))]
    ) -> some View {
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
    
    /// List of icons as used in the `IconPicker`
    let icons: [String] = [
        "bookmark.fill", "mappin", "graduationcap.fill", "dice.fill", "figure.dance",
        "key.horizontal.fill", "mountain.2.fill", "car.rear.fill", "tree.fill", "fish.fill",
        "mug.fill", "case.fill", "lightbulb.fill", "house.fill", "doc.fill", "person.fill"
    ]
    
    /// Produces an icon picker UI, saving the selection within the `selection` parameter
    /// and a colorId in the bounds of the `colors` list for the background of a selected icon.
    /// ```
    /// IconPicker(selection: $iconName, colorId: $colorId)
    /// ```
    /// - Parameters:
    ///     - selection: `Binding<String>` The binding to store the selection to
    ///     - colorId: `Int16` The colorId for the selected icon background color
    ///     - columns: `[GridItem]` The columns to use for the `GridView`
    @ViewBuilder
    func IconPicker(
        selection: Binding<String>,
        colorId: Int16,
        columns: [GridItem] = [GridItem(.adaptive(minimum: 40))]
    ) -> some View {
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
