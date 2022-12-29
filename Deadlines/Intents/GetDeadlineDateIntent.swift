//
//  GetDeadlineDateIntent.swift
//  Deadlines
//
//  Created by Jack Devey on 28/12/2022.
//

import Foundation
import AppIntents
import SwiftUI

struct GetDeadlineDateIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Get Deadline Date"
    
    static var description = IntentDescription("Returns the deadline due date")
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    func perform() async throws -> some ReturnsValue {
        return .result(value: items[0].date)
    }
    
}
