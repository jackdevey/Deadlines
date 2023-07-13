//
//  DeadlineFilter.swift
//  Deadlines
//
//  Created by Jack Devey on 13/07/2023.
//

import Foundation

class DeadlineFilterer: ObservableObject {
    @Published var isUrgent: Bool = false
    @Published var isSubmitted: Bool = false
    @Published var hasExpired: Bool = false
    
    init() {}
    
    var hasFilterApplied: Bool {
        return isSubmitted || hasExpired || isUrgent
    }
    
    func filter(unfiltered: [Deadline]) -> [Deadline] {
        
        var deadlines = unfiltered
        // Urgent
        if self.isUrgent {
            deadlines = deadlines.filter({ deadline in
                return deadline.isUrgent
            })
        }
        // Submitted
        if self.isSubmitted {
            deadlines = deadlines.filter({ deadline in
                return deadline.isSubmitted
            })
        }
        // Has expired
        if self.hasExpired {
            deadlines = deadlines.filter({ deadline in
                return deadline.due <= Date()
            })
        }
        
        return deadlines
    }
    
}
