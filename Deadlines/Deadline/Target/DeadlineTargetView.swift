//
//  DeadlineTargetView.swift
//  Deadlines
//
//  Created by Jack Devey on 20/01/2023.
//

import SwiftUI

struct DeadlineTargetView: View {
    
    var body: some View {
        
        Form {
            Picker("Grade", selection: .constant(Grade.first)) {
                Text("First").tag(Grade.first)
                Text("2.1").tag(Grade.twoOne)
                Text("2.2").tag(Grade.twoTwo)
                Text("2.3").tag(Grade.twoThree)
                Text("Third").tag(Grade.third)
            }
        }
        
        .navigationTitle("Target")
        
    }
    
}

enum Grade: String, CaseIterable, Identifiable {
    
    case first, twoOne, twoTwo, twoThree, third
    var id: Self { self }
    
}
