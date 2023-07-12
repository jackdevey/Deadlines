//
//  DeadlineLink.swift
//  Deadlines
//
//  Created by Jack Devey on 12/07/2023.
//

import Foundation
import SwiftData
import UIKit

@Model public class DeadlineLink {
    // Attributes
    var name: String = ""
    var url: String = ""
    var done: Bool = false
    var order: Int = -1
    
    // Relationships
    var deadline: Deadline?
    
    // Generic
    public var id: UUID = UUID()
    var lastEdited: Date = Date()
    var lastEditedBy: String = UIDevice.current.name
    
    init() {}
}
