//
//  NewInstallView.swift
//  Deadlines
//
//  Created by Jack Devey on 17/01/2023.
//

import SwiftUI

struct WelcomeView: View {
    
    // Get viewContext
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var items: FetchedResults<Item>
    
    // Get if is new install (to set to false)
    @AppStorage("context.newInstall") var isNewInstall = true
    
    @State var policySeen = false
            
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // Show title
                VStack(alignment: .center) {
                    Image(uiImage: UIImage(named: "IconDefault") ?? UIImage())
                        .resizable()
                        .frame(width: 75, height: 75)
                        .cornerRadius(15)
                    Text("Deadlines")
                        .font(.largeTitle)
                        .bold()
                    Text("Simple, Intuitive & Secure")
                        .foregroundColor(.secondary)
                }
                .frame(width: .greedy)
                Spacer()
                // Features
                VStack(alignment: .leading) {
                    // Privacy
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color.systemGreen)
                                .frame(width: 45, height: 45)
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        }
                        VStack(alignment: .leading) {
                            // Deadline name
                            Text("Privacy focussed")
                                .font(.headline)
                            // Deadline due
                            Text("Deadlines is built with privacy in mind and great encryption")
                                .foregroundColor(.secondary)
                        }
                        .padding([.leading], 5)
                    }
                    .padding(5)
                    // iCloud
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color.systemBlue)
                                .frame(width: 45, height: 45)
                            Image(systemName: "icloud.fill")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        }
                        VStack(alignment: .leading) {
                            // Deadline name
                            Text("Syncs with iCloud")
                                .font(.headline)
                            // Deadline due
                            Text("Deadlines synchronises data in your iCloud account, on all your devices")
                                .foregroundColor(.secondary)
                        }
                        .padding([.leading], 5)
                    }
                    .padding(5)
                    // Tags
                    HStack(alignment: .top) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color.systemIndigo)
                                .frame(width: 45, height: 45)
                            Image(systemName: "number")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        }
                        VStack(alignment: .leading) {
                            // Deadline name
                            Text("Group with tags")
                                .font(.headline)
                            // Deadline due
                            Text("Group multiple Deadlines together with tags and enhance searching")
                                .foregroundColor(.secondary)
                        }
                        .padding([.leading], 5)
                    }
                    .padding(5)
                }
                Spacer()
                // Privacy stuff
                VStack(alignment: .center) {
                    // Privacy policy link
                    Link(destination: URL(string: "https://deadlines.jw3.uk/privacy")!) {
                        Label("Read Privacy Policy", systemImage: "doc")
                    }
                    .onPress {
                        policySeen = true
                    }
                    // Agree button
                    NavigationLink {
                        // Make first deadline
                        if items.count == 0 {
                            NewEditDeadlineView(new: true, title: "First deadline", showCancel: false, cancelHandler: {},
                                                confirmHandler: { name, date, color, iconName in
                                // Make a new deadline
                                let deadline = Item(context: viewContext)
                                deadline.id = UUID()
                                deadline.name = name
                                deadline.date = date
                                deadline.color = color
                                deadline.iconName = iconName
                                // Save if needed
                                _ = try? viewContext.saveIfNeeded()
                                // Save not new
                                isNewInstall = false
                            })
                            .onAppear {
                                // Ask for notifs
                                NotificationsManager().askForPermission()
                            }
                        } else {
                            VStack {}
                                .onAppear {
                                    isNewInstall = false
                                    // Ask for notifs
                                    NotificationsManager().askForPermission()
                                }
                        }
                    } label: {
                        Label("I agree to the Privacy Policy", systemImage: "person.fill.checkmark")
                            .font(.headline)
                            .padding(3)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    // Footer text about have to accent
                    Text("To use Deadlines you must agree to the privacy policy.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .frame(width: .greedy)
            }
            .frame(width: .greedy)
            .padding()
        }
    }
}
