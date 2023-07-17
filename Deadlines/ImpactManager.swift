//
//  ImpactManager.swift
//  Deadlines
//
//  Created by Jack Devey on 17/07/2023.
//

import Foundation
import UIKit

struct ImpactManager {
    
    static func light() {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
    }
    
    static func medium() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
    
    static func heavy() {
        let impact = UIImpactFeedbackGenerator(style: .heavy)
        impact.impactOccurred()
    }
    
    static func rigid() {
        let rigid = UIImpactFeedbackGenerator(style: .rigid)
        rigid.impactOccurred()
    }
    
    static func soft() {
        let impact = UIImpactFeedbackGenerator(style: .soft)
        impact.impactOccurred()
    }
    
}
