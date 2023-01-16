//
//  CodableExtensions.swift
//  Deadlines
//
//  Created by Jack Devey on 16/01/2023.
//

import Foundation

extension Encodable {
    /// Encoded function
    public func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

/// Item
extension Item: Encodable {
    
    enum CodeKeys: CodingKey {
        case id
        case name
        case submitted
        case note
        case iconName
        case date
        case color
        case timestamp
        case links
        case todos
        case tags
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodeKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(submitted, forKey: .submitted)
        try container.encode(note, forKey: .note)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(date, forKey: .date)
        try container.encode(color, forKey: .color)
        try container.encode(timestamp, forKey: .timestamp)
    }
}

/// Links
extension DeadlineLink: Encodable {
    
    enum CodeKeys: CodingKey {
        case id
        case name
        case placement
        case url
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodeKeys.self)
        try container.encode (id, forKey: .id)
        try container.encode (name, forKey: .name)
        try container.encode (placement, forKey: .placement)
        try container.encode (url, forKey: .url)
    }
}

/// Todos
extension DeadlineTodo: Encodable {
    
    enum CodeKeys: CodingKey {
        case id
        case name
        case placement
        case done
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodeKeys.self)
        try container.encode (id, forKey: .id)
        try container.encode (name, forKey: .name)
        try container.encode (placement, forKey: .placement)
        try container.encode (done, forKey: .done)
    }
}

/// Tags
extension Tag: Encodable {
    
    enum CodeKeys: CodingKey {
        case id
        case text
        case timestamp
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodeKeys.self)
        try container.encode (id, forKey: .id)
        try container.encode (text, forKey: .text)
        try container.encode (timestamp, forKey: .timestamp)
    }
}


