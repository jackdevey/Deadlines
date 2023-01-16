//
//  PrivacyView.swift
//  Deadlines
//
//  Created by Jack Devey on 15/01/2023.
//

import CoreData
import SwiftUI
import CloudKitGDPR
import CloudKit
import ZIPFoundation
import UniformTypeIdentifiers
import SwiftTipJar

struct TipJarView: View {
    
    @EnvironmentObject var tipJar: SwiftTipJar
    @State private var showingThankYou = false
    
    var body: some View {
        List {
            // Show title
            Section {
                Text("Deadlines is (and always) completely free, but any financial support would be greatly appreciated")
                    .foregroundColor(.secondary)
                    .font(.headline)
                Text("If you are enjoying the app, tipping will directly support development costs. It is completely optional and tipping will not unlock any extra app features")
                    .foregroundColor(.secondary)
            }
            // App security section
            Section(
                header: Text("Tip Sizes"),
                footer: Text("Tips are greatly appreciated, however they are completely optional")
            ) {
                ForEach(tipJar.tips, id:\.identifier) { tip in
                    HStack {
                        NiceIconLabel(text: tip.displayName, color: .systemBlue, iconName: "sterlingsign")
                        Spacer()
                        Button(tip.displayPrice) {
                            tipJar.initiatePurchase(productIdentifier: tip.identifier)
                        }
                    }
                }
            }
        }
        // Show title
        .navigationTitle("Tip Jar")
        // Tip Jar code
        .onAppear {
            // On successful tip
            tipJar.transactionSuccessfulBlock = {
                DispatchQueue.main.async {
                    self.showingThankYou = true
                }
            }
            // On tip failed
            tipJar.transactionFailedBlock = {
                
            }
        }
        // Thank you message
        .sheet(isPresented: $showingThankYou) {
            Text("Cheers")
        }
    }
    
}


