//
//  TagViews.swift
//  Deadlines
//
//  Created by Jack Devey on 11/01/2023.
//

import Foundation
import SwiftUI

extension Tag {
    
    @ViewBuilder
    func InlineView() -> some View {
        Text("#\(self.text ?? "Unknown")")
            .font(.system(.subheadline, design: .rounded))
            .foregroundColor(.systemIndigo)
            .bold()
    }
    
    @ViewBuilder
    func LabelView() -> some View {
        NiceIconLabelFlat(text: self.text ?? "Unknown", color: .quaternarySystemFill, iconName: "number")
    }
    
}
