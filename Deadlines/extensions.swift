//
//  extensions.swift
//  Deadlines
//
//  Created by Jack Devey on 25/01/2023.
//

import Foundation

extension InnerGroup {
    
    var sTitle: String {
        self.title ?? "Unknown"
    }
    
    var sItems: [InnerItem] {
        self.items?.allObjects as? [InnerItem] ?? []
    }
    
}
