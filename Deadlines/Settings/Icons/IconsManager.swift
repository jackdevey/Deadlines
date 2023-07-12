//
//  IconSettings.swift
//  Deadlines
//
//  Created by Jack Devey on 10/01/2023.
//

import Foundation
import SwiftUI

public final class IconsManager: ObservableObject {
    
    // Index of icon in list
    @Published public var selected: String?
    
    // List of icons
    public private(set) var iconGrid: [IconGroup] = []
    
    // Get the name of the currentIcon
    public var currentIconName: String? {
        UIApplication.shared.alternateIconName
    }
    
    // Each icon group data type
    public struct IconGroup {
        public let name: String?
        public let icons: [Icon]
    }
    
    // Each icon data type
    public struct Icon {
        public let name: String
        public let iconName: String?
        public let image: UIImage?
        public let desc: String
    }
    
}
