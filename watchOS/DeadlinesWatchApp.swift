//
//  DeadlinesWatchApp.swift
//  DeadlinesWatch Watch App
//
//  Created by Jack Devey on 16/07/2023.
//

import SwiftUI

@main
struct DeadlinesWatch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .useDataContainer()
                .userActivity("uk.jw3.Deadlines.handoff.app", isActive: true) { activity in
                    activity.isEligibleForSearch = true
                    activity.isEligibleForHandoff = true
                    activity.becomeCurrent()
                }
        }
    }
}
