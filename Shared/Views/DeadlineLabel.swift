//
//  DeadlineLabel.swift
//  Deadlines
//
//  Created by Jack Devey on 12/07/2023.
//

import Foundation
import SwiftUI

struct DeadlineLabel: View {
    
    var text: String
    var icon: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .imageScale(.medium)
                .padding(.trailing, 5)
            Text(text)
        }
        .foregroundStyle(.primary)
    }
    
}
