//
//  OpenAppIntent.swift
//  Deadlines
//
//  Created by Jack Devey on 09/07/2023.
//

import Foundation
import AppIntents

struct OpenAppIntent: AppIntent {
    static var title: LocalizedStringResource = "Open App"

    @MainActor
    func perform() async throws -> some IntentResult {
        let viewContext = PersistenceController.shared.container.viewContext
        viewContext.hasChanges
        return .result()
    }
  
    static var openAppWhenRun: Bool = true
}

struct OpenAppShortcut: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenAppIntent(),
            phrases: ["Open \(.applicationName)"],
            systemImageName: "arrow.up.forward.app"
        )
    }
}
