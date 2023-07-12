//
//  DeadlinesApp.swift
//  Deadlines
//
//  Created by Jack Devey on 23/12/2022.
//

import SwiftUI

@main
struct DeadlinesApp: App {
//    @AppStorage("context.newInstall") var isNewInstall = true
//            
//    let tipJar: SwiftTipJar
//
//        init() {
//            // Load tips
//            tipJar = SwiftTipJar(tipsIdentifiers: Set([
//                "uk.jw3.Deadlines.smallTip",
//                "uk.jw3.Deadlines.mediumTip",
//                "uk.jw3.Deadlines.largeTip"
//            ]))
//            tipJar.startObservingPaymentQueue()
//            tipJar.productsRequest?.start()
//        }
    
//    var store = Store()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .useDataContainer()
                .onAppear {
                    SystemSettingsHelper.setAppInfo()
                }
            
            
//            if isNewInstall {
//                WelcomeView()
//                    .useDataContainer()
//            } else {
//                //TabView {
//                    ContentView()
//                        .useDataContainer()
//                        .environmentObject(tipJar)
//                        .onDisappear {
//                            if viewContext.hasChanges {
//                                try? viewContext.save()
//                            }
//                        }
//                        .onOpenURL { incomingURL in
//                            print("App was opened via URL: \(incomingURL)")
//                            handleIncomingURL(incomingURL)
//                        }
////                        .tabItem {
////                            Label("Deadlines", systemImage: "list.bullet.rectangle")
////                        }
////                    CalendarView()
////                        .tabItem {
////                            Label("Calendar", systemImage: "calendar")
////                        }
//                //}
//            }
        }
    }

}
