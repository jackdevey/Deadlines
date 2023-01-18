//
//  IconSettings.swift
//  Deadlines
//
//  Created by Jack Devey on 10/01/2023.
//

#if os(iOS)

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
    
    public init() {
        // Core icons
        iconGrid.append(IconGroup(name: nil, icons: [
            // Add default icon to icons list
            Icon(name: "Default", iconName: nil, image: UIImage(named: "IconDefault")),
            // Add flat icon to icons list
            Icon(name: "Flat", iconName: "Flat", image: UIImage(named: "IconFlat")),
            // Add emoji icon to icons list
            Icon(name: "Emoji", iconName: "Emoji", image: UIImage(named: "IconEmoji"))
        ]))
        // Other apps section
        iconGrid.append(IconGroup(name: "Other Apps", icons: [
            // Add aside icon to icons list
            Icon(name: "Aside", iconName: "Aside", image: UIImage(named: "IconAside")),
            // Add macros icon to icons list
            Icon(name: "Aside", iconName: "Aside", image: UIImage(named: "IconAside"))
        ]))
        // Special icons
        iconGrid.append(IconGroup(name: "Special", icons: [
            // Add black icon to icons list
            Icon(name: "Black", iconName: "Black", image: UIImage(named: "IconBlack"))
        ]))
        // Set icon index
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
    }
    
}

#endif
