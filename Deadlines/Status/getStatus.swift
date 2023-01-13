//
//  getStatus.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import Foundation
import SwiftUI

extension Item {
    
    var colour: Color {
        return DeadlineCustomisations().colors[Int(color)]
    }
    
    public var tagNames: [String] {
        if let tags = self.tags {
            var arr: [String] = []
            for tag in tags.sortedArray(using: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)]) as! [Tag] {
                arr.append("#\(tag.text ?? "Unknown")")
            }
            return arr
        }
        return []
    }
    
    func getColour() -> Color {
        switch self.color {
        default: return .purple
        }
    }
    
    func getIconName() -> String {
        return self.iconName ?? "figure.dance"
    }

    
    var status: Status {
        if self.submitted {
            return Status.submitted
        } else if Date.now > self.date! {
            return Status.pastDue
        } else if checklistItemsCompletedPercentage == 100 {
            return Status.completed
        } else {
            return Status.progressing
        }
    }
    
    public var daysUntil: String {
        // Create diff
        let diff = Calendar.current.dateComponents([.day, .hour], from: Date.now, to: date!)
        if let days = diff.day {
            return "\(days) \(days == 1 ? "day" : "days")"
        }
        return "\(diff.day ?? 0) days"
    }
    
    public var checklistItemsTotal: Int {
        return todos?.array.count ?? 0
    }
    
    private var checlistItemsCompleted: Float {
        var count = 0
        for todo in todos?.array as! [DeadlineTodo] {
            if todo.done {
                count += 1
            }
        }
        return Float(count)
    }
    
    public var checklistItemsCompletedPercentage: Int {
        // Return 0 if there is no total items
        // (avoids division by 0 error)
        if checklistItemsTotal == 0 { return 0 }
        // Return percentage rounded to int
        return Int(checlistItemsCompleted / Float(checklistItemsTotal) * 100)
    }

}
