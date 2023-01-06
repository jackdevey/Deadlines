//
//  TodoView.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import Foundation
import SwiftUI

struct TodoView: View {
    
    @ObservedObject var todo: DeadlineTodo
    
    var handler: (DeadlineTodo) -> ()
    
    
    var body: some View {
        
        // Show each link as a link (with label)
        Toggle(todo.name ?? "", isOn: $todo.done)
            .toggleStyle(CheckboxToggleStyle())
            .onChange(of: todo.done) { _ in
                // Save changes
                handler(todo)
            }
        
    }
    
}
