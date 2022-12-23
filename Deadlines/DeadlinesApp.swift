//
//  DeadlinesApp.swift
//  Deadlines
//
//  Created by Jack Devey on 23/12/2022.
//

import SwiftUI

@main
struct DeadlinesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
