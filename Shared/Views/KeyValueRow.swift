//
//  KeyValueRow.swift
//  Deadlines
//
//  Created by Jack Devey on 13/07/2023.
//

import Foundation
import SwiftUI

struct KeyValueRow<Key: View, Value: View>: View {
    
    var key: Key
    var value: Value
    
    init(@ViewBuilder key: () -> Key, @ViewBuilder value: () -> Value) {
        self.key = key()
        self.value = value()
    }
    
    var body: some View {
        HStack {
            key.foregroundStyle(.primary)
            Spacer()
            value.foregroundStyle(.secondary)
        }
    }
}
