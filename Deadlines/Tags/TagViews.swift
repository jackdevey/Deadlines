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
        NiceIconLabel(
            text: Text(self.text ?? "Unknown")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.systemIndigo)
                .bold(),
            background: RoundedRectangle(cornerRadius: 5)
                .fill(.ultraThickMaterial)
                .frame(width: 30, height: 30),
            foreground: Image(systemName: "number")
                .imageScale(.small)
                .foregroundColor(.primary)
        )
    }
    
    @ViewBuilder
    func ButtonView() -> some View {
        Button {
            
        } label: {
            Text("#\(self.text ?? "Unknown")")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.white)
                .bold()
        }
        .buttonStyle(.borderedProminent)
    }
    
}
