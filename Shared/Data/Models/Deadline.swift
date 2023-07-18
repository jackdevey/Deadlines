//
//  Deadline.swift
//  Deadlines
//
//  Created by Jack Devey on 11/07/2023.
//

import Foundation
import SwiftData
import UIKit

@Model public class Deadline: ObservableObject, Hashable {
    // Attributes
    var name: String = ""
    var due: Date = Date()
    var icon: String = "app"
    var colorId: Int = 0
    var isSubmitted: Bool = false
    var isUrgent: Bool = false
    
    // Relationships
    @Relationship(.cascade, inverse: \DeadlineTodo.deadline) var todos: [DeadlineTodo]?
    @Relationship(.cascade, inverse: \DeadlineLink.deadline) var links: [DeadlineLink]?
    
    // Generic
    public var id: UUID? = UUID()
    var lastEdited: Date = Date()
    var lastEditedBy: String = "UIDevice.current.name"
    
    public init(name: String, due: Date, icon: String, colorId: Int) {
        self.id = UUID()
        self.name = name
        self.due = due
        self.icon = icon
        self.colorId = colorId
    }
    
    public init() {}
    
    var percentCompleted: Float {
        let completed = self.completedLinksCount + self.completedTodosCount
        let total = (self.todos?.count ?? 0) + (self.links?.count ?? 0)
        if total == 0 {
            return 0
        }
        let percent = Float(completed / total)
        return round(percent * 10) / 10
    }
    
    var completedTodosCount: Int {
        return self.todos?.filter { todo in todo.done }.count ?? 0
    }
    
    var completedLinksCount: Int {
        return self.links?.filter { link in link.done }.count ?? 0
    }
    
    var progress: String {
        // No use
        if (self.todos == nil && self.links == nil) || (self.todos?.count == 0 && self.links?.count == 0) {
            return "Untracked"
        }
        
        // Submitted
        if (self.isSubmitted) {
            return "Submitted"
        }
        
        return "\(self.percentCompleted * 100)% Complete"
    }
    
    var progressDescription: String {
        // No use
        if (self.percentCompleted == 0.0) {
            return "Add some checklist items or links to begin tracking your progress."
        }
        // Submitted
        if (self.isSubmitted) {
            return "This Deadline is marked as submitted with 69% completion."
        }
        
        // Progress message building
        var message = "You have completed "
        
        if (self.todos != nil || self.todos?.count != 0) {
            message += "69 of \(self.todos!.count) checklist items"
            
            if (self.links != nil || self.links?.count != 0) {
                message += " and "
            }
        }
        
        if (self.links != nil || self.links?.count != 0) {
            message += "69 of \(self.links!.count) links"
        }
        
        message += "."
        
        return message
    }
    
    /// Add new todo to the deadline
    
    func addTodo(todo: DeadlineTodo) {
        if self.todos != nil {
            // Deadline has todos already, add at index 0
            self.todos!.insert(todo, at: 0)
        } else {
            // Deadline has no todos, start an array with this todo
            self.todos = [todo]
        }
    }
}
