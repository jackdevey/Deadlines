//
//  CheckboxToggleStyle.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
  @Environment(\.isEnabled) var isEnabled

  func makeBody(configuration: Configuration) -> some View {
    Button(action: {
      configuration.isOn.toggle() // toggle the state binding
    }, label: {
      HStack {
          Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            .imageScale(.large)
            .foregroundColor(configuration.isOn ? .accentColor : .secondary)
          configuration.label
      }
    })
    .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
    .disabled(!isEnabled)
  }
    
}
