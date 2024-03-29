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
    static let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .indigo, .pink, .purple, .brown, .gray]
    
    /// Gets the associated color from the `colorId` provided
    /// > Might return nil if out of bounds
    /// - Parameters:
    ///     - colorId: `Int` The colorId for the color
    /// - Returns: `Color?` The associated color or nil
    static func getColor(colorId: Int) -> Color {
        if Int(colorId) < colors.count - 1 {
            return colors[Int(colorId)]
        } else {
            return .gray
        }
    }

    /// Produces a color picker UI, saving the selection within the `selection` parameter
    /// as a colorId in the bounds of the `colors` list.
    /// ```
    /// ColorPicker(selection: $colorId)
    /// ```
    /// > The `selection` parameter holds the colorId in Int16 value, not the `Color` value
    /// > itself. Use `getColor(colorId: Int)` to convert this to a `Color` type.
    /// - Parameters:
    ///     - selection: `Binding<Int>` The binding to store the selection to
    ///     - columns: `[GridItem]` The columns to use for the `GridView`
    @ViewBuilder
    static func ColorPicker(
        selection: Binding<Int>,
        columns: [GridItem] = [GridItem(.adaptive(minimum: 40))]
    ) -> some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(colors.indices, id: \.self) { idx in
                ZStack {
                    Circle()
                        .fill(colors[idx].gradient)
                        .frame(width: 40, height: 40)
                    if colors[Int(selection.wrappedValue)] == colors[idx] {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                }
                .onTapGesture {
                    selection.wrappedValue = idx
                }
            }
        }
    }
    
    /// List of icons as used in the `IconPicker`
    static let icons: [String] = [
        "bookmark.fill", "mappin", "graduationcap.fill", "dice.fill", "figure.dance",
        "key.horizontal.fill", "mountain.2.fill", "car.rear.fill", "tree.fill", "drop.triangle.fill",
        "mug.fill", "case.fill", "lightbulb.fill", "house.fill", "doc.fill", "person.fill",
        "camera.fill", "camera.macro.circle.fill", "photo.fill.on.rectangle.fill", "f.cursive.circle.fill",
        "function", "x.squareroot", "location.circle.fill", "seal.fill", "hourglass.circle.fill",
        "flame.fill", "hare.fill", "tortoise.fill", "fish.fill", "bird.fill", "lizard.fill", "carrot.fill",
        "pawprint.fill", "ladybug.fill"
    ]
    
    /// Produces an icon picker UI, saving the selection within the `selection` parameter
    /// and a colorId in the bounds of the `colors` list for the background of a selected icon.
    /// ```
    /// IconPicker(selection: $iconName, colorId: $colorId)
    /// ```
    /// - Parameters:
    ///     - selection: `Binding<String>` The binding to store the selection to
    ///     - colorId: `Int` The colorId for the selected icon background color
    ///     - columns: `[GridItem]` The columns to use for the `GridView`
    @ViewBuilder
    static func IconPicker(
        selection: Binding<String>,
        colorId: Int,
        columns: [GridItem] = [GridItem(.adaptive(minimum: 40))]
    ) -> some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(icons, id: \.self) { icon in
                ZStack {
                    Circle()
                        .fill(selection.wrappedValue == icon ? colors[Int(colorId)].gradient : Color.secondary.gradient)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .foregroundColor(selection.wrappedValue == icon ? .white : .secondary)
                }
                .onTapGesture {
                    selection.wrappedValue = icon
                }
            }
        }
    }
}
