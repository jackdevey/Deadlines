//
//  DeadlinesApp.swift
//  Deadlines
//
//  Created by Jack Devey on 23/12/2022.
//

import SwiftUI
import SwiftTipJar

@main
struct DeadlinesApp: App {
    @AppStorage("context.newInstall") var isNewInstall = true
    
    let viewContext = PersistenceController.shared.container.viewContext
        
    let tipJar: SwiftTipJar

        init() {
            // Load tips
            tipJar = SwiftTipJar(tipsIdentifiers: Set([
                "uk.jw3.Deadlines.smallTip",
                "uk.jw3.Deadlines.mediumTip",
                "uk.jw3.Deadlines.largeTip"
            ]))
            tipJar.startObservingPaymentQueue()
            tipJar.productsRequest?.start()
        }
    
    var store = Store()

    var body: some Scene {
        WindowGroup {
            if isNewInstall {
                WelcomeView()
                    .environment(\.managedObjectContext, viewContext)
            } else {
                TabView {
                    ContentView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(tipJar)
                        .onDisappear {
                            if viewContext.hasChanges {
                                try? viewContext.save()
                            }
                        }
//                        .tabItem {
//                            Label("Deadlines", systemImage: "list.bullet.rectangle")
//                        }
//                    CalendarView()
//                        .tabItem {
//                            Label("Calendar", systemImage: "calendar")
//                        }
                }
            }
        } 
    }
}
