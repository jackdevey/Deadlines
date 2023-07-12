//
//  Core.swift
//  Deadlines
//
//  Created by Jack Devey on 12/07/2023.
//

import SwiftUI
import SwiftData

struct DCViewModifier: ViewModifier {
    let container: ModelContainer
    
    init() {
        container = try! ModelContainer(for: SwiftData.Schema([
            Deadline.self,
            DeadlineTodo.self,
            DeadlineLink.self
        ]), configurations: [
            ModelConfiguration(
                sharedAppContainerIdentifier: "group.uk.jw3.Deadlines",
                cloudKitContainerIdentifier: "iCloud.uk.jw3.Deadlines"
            )
        ])
    }
    
    func body(content: Content) -> some View {
        content
            .modelContainer(container)
    }
}

public extension View {
    func useDataContainer() -> some View {
        modifier(DCViewModifier())
    }
}
