//
//  getStatus.swift
//  Deadlines
//
//  Created by Jack Devey on 02/01/2023.
//

import Foundation

extension Item {
    
    func getStatus() -> Status {
        if self.submitted {
            return Status.submitted
        } else if Date.now > self.date! {
            return Status.pastDue
        } else {
            return Status.progressing
        }
    }
    
    var percentComplete: Float {
        let total = Float(self.todos?.array.count ?? 0)
        var done = 0.0
        
        for todo in self.todos!.array {
            if (todo as! DeadlineTodo).done {
                done += 1
            }
        }
        
        return Float(done) / total * 100
    }

}
