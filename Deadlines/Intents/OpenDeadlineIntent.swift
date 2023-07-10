//
//  OpenDeadlineIntent.swift
//  Deadlines
//
//  Created by Jack Devey on 10/07/2023.
//

import Foundation
import AppIntents

struct OpenDeadlineIntent: AppIntent {
    @Parameter(title: "Deadline")
    var deadline: ItemEntity

    static var title: LocalizedStringResource = "Open Deadline"

    static var openAppWhenRun = true

    @MainActor
    func perform() async throws -> some IntentResult {
//        guard try await $deadline.requestConfirmation(for: deadline, dialog: "Are you sure you want to clear read state for \(book)?") else {
//            return .result()
//        }
//        Navigator.shared.openBook(book)
        return .result()
    }

    static var parameterSummary: some ParameterSummary {
        Summary("Open \(\.$deadline)")
    }
  
    init() {}

    init(deadline: ItemEntity) {
        self.deadline = deadline
    }
}
