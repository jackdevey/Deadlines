//
//  DeadlineChangeIconView.swift
//  Deadlines
//
//  Created by Jack Devey on 12/01/2023.
//

import SwiftUI

struct DeadlineChangeIconView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var deadline: Item
    
    let icons: [String] = [
        "bookmark.fill", "mappin", "graduationcap.fill", "dice.fill", "figure.dance",
        "key.horizontal.fill", "mountain.2.fill", "car.rear.fill", "tree.fill", "fish.fill",
        "mug.fill", "case.fill", "lightbulb.fill", "house.fill", "doc.fill", "person.fill"
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Preview")) {
                    deadline.RowView()
                }
                Section() {
                    // Show all available colours
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0...(deadlineColors.endIndex - 1), id: \.self) { idx in
                            ColorPicker(idx: idx)
                        }
                    }
                    
                }
                Section() {
                    // Show all available icons
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(icons, id: \.self) { icon in
                            IconPicker(icon: icon)
                        }
                    }
                }
            }
            // Set title
            .navigationTitle("Change Icon")
            .navigationBarTitleDisplayMode(.inline)
            // Show toolbar
            .toolbar {
                // Cancel
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        // Close
                        dismiss()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func ColorPicker(idx: Int) -> some View {
        ZStack {
            Circle()
                .fill(deadlineColors[idx])
                .frame(width: 40, height: 40)
            if deadlineColors[Int(deadline.color)] == deadlineColors[idx] {
                Image(systemName: "checkmark")
            }
        }
        .onPress {
            deadline.color = Int16(idx)
        }
    }
    
    @ViewBuilder
    func IconPicker(icon: String) -> some View {
        ZStack {
            if deadline.iconName == icon {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 40, height: 40)
            } else {
                Circle()
                    .fill(Color.darkGray)
                    .frame(width: 40, height: 40)
            }
            Image(systemName: icon)
        }
        .onPress {
            deadline.iconName = icon
        }
    }
}

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
let availableWidth: CGFloat
let data: Data
let spacing: CGFloat
let alignment: HorizontalAlignment
let content: (Data.Element) -> Content
@State var elementsSize: [Data.Element: CGSize] = [:]

var body : some View {
    VStack(alignment: alignment, spacing: spacing) {
        ForEach(computeRows(), id: \.self) { rowElements in
            HStack(spacing: spacing) {
                ForEach(rowElements, id: \.self) { element in
                content(element)
                        .fixedSize()
                        .readSize { size in
                            elementsSize[element] = size
                        }
                }
            }
        }
    }
}

func computeRows() -> [[Data.Element]] {
    var rows: [[Data.Element]] = [[]]
    var currentRow = 0
    var remainingWidth = availableWidth

    for element in data {
      let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

      if remainingWidth - (elementSize.width + spacing) >= 0 {
        rows[currentRow].append(element)
      } else {
        currentRow = currentRow + 1
        rows.append([element])
        remainingWidth = availableWidth
      }

      remainingWidth = remainingWidth - (elementSize.width + spacing)
    }

    return rows
}
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
          GeometryReader { geometryProxy in
            Color.clear
              .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
          }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
