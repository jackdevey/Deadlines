//
//  Deadline.swift
//  Deadlines
//
//  Created by Jack Devey on 11/07/2023.
//

import Foundation
import SwiftData
import UIKit

@Model public class Deadline {
    // Attributes
    var name: String = ""
    var due: Date = Date()
    var icon: String = "app"
    var colorId: Int = 0
    
    // Relationships
    @Relationship(.cascade, inverse: \DeadlineTodo.deadline) var todos: [DeadlineTodo]?
    @Relationship(.cascade, inverse: \DeadlineLink.deadline) var links: [DeadlineLink]?
    
    // Generic
    public var id: UUID? = UUID()
    var lastEdited: Date = Date()
    var lastEditedBy: String = UIDevice.current.name
    
    public init(name: String, due: Date, icon: String, colorId: Int) {
        self.id = UUID()
        self.name = name
        self.due = due
        self.icon = icon
        self.colorId = colorId
    }
}
