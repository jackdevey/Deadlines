////
////  DeadlineTodoStatusExplanationView.swift
////  Deadlines
////
////  Created by Jack Devey on 02/01/2023.
////
//
//import SwiftUI
//
//struct SupportStatusView: View {
//    var body: some View {
//        List {
//            Section {
//                Text("A status represents how complete a deadline is, taking into account how much time is left to complete it")
//                    .foregroundColor(.secondary)
//                    .font(.headline)
//                Text("Deadlines can fall in to any of the categories below")
//                    .foregroundColor(.secondary)
//            }
//            Section {
//                ForEach(Status.allCases, id: \.hashValue) { status in
//                    StatusView(status: status, showDescription: true)
//                }
//            } footer: {
//                Text("A status will automatically update throughout the duration of the deadline, until the deadline is marked as submitted")
//            }
//        }
//        .navigationTitle("Status explained")
//    }
//}
