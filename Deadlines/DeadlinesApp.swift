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
    let viewContext = PersistenceController.shared.container.viewContext
    
    var store = Store()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
                .onDisappear {
                    if viewContext.hasChanges {
                        try? viewContext.save()
                    }
                }
        }
    }
}
