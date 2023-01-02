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
        } else {
            return Status.progressing
        }
    }

}
