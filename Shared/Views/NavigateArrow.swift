//
//  NavigateArrow.swift
//  Deadlines
//
//  Created by Jack Devey on 13/07/2023.
//

import SwiftUI

struct NavigateArrow<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
            Spacer()
            Image(systemName: "arrow.forward")
                .tint(.secondary)
                .imageScale(.medium)
        }
    }
}
