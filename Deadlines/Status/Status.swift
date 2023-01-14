//
//  Status.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import Foundation
import SwiftUI


enum Status: CaseIterable {
    
    case submitted, completed, progressing, stale, pastDue
    
    var name: String {
        switch self {
        case .submitted: return "Submitted"
        case .completed: return "Completed"
        case .progressing: return "Progressing"
        case .stale: return "Stale"
        case .pastDue: return "Past due"
        }
    }
    
    var description: String {
        switch self {
        case .submitted: return "Work has been submitted"
        case .completed: return "All required work is completed"
        case .progressing: return "Work is happening at a suitable pace"
        case .stale: return "No progress made in a few days"
        case .pastDue: return "Due date has passed"
        }
    }
    
    var iconName: String {
        switch self {
        case .submitted: return "paperplane"
        case .completed: return "checkmark"
        case .progressing: return "bolt"
        case .stale: return "exclamationmark"
        case .pastDue: return "calendar"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .submitted: return .systemBlue
        case .completed: return .systemGreen
        case .progressing: return .systemPurple
        case .stale: return .systemYellow
        case .pastDue: return .systemRed
        }
    }
    
}

struct StatusView: View {
    
    var status: Status
    var showDescription: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: status.iconName + ".circle")
                    .imageScale(.large)
                    .foregroundColor(status.iconColor)
                Text(status.name)
            }
            if showDescription {
                Text(status.description)
                    .foregroundColor(.secondary)
            }
        }
    }
}
