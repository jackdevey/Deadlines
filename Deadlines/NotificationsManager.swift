//
//  NotificationsManager.swift
//  Deadlines
//
//  Created by Jack Devey on 06/01/2023.
//

import Foundation
import UserNotifications

struct NotificationsManager {
    
    func askForPermission(accepted: (() -> Void)? = nil, rejected: (() -> Void)? = nil) {
        // Request permissions for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            // If permission granted
            if success {
                // Run accepted function (if
                // exists)
                if let accepted = accepted {
                    accepted()
                }
            } else if let error = error {
                // Log error
                print(error.localizedDescription)
                // Run rejected function (if
                // exists)
                if let rejected = rejected {
                    rejected()
                }
            }
        }
    }
    
    func scheduleDeadlineDueAlert(deadline: Item) {
        // Create the notification
        let content = setContent(title: deadline.name!, subtitle: "Due in now")
        // Set trigger to deadline due date
        let trigger = triggerToDate(date: deadline.date!)
        // Schedule the notification
        schedule(content: content, trigger: trigger)
    }
    
    func setContent(title: String, subtitle: String, sound: UNNotificationSound = UNNotificationSound.default) -> UNMutableNotificationContent {
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = sound
        // Return content
        return content
    }
    
    func triggerToDate(date: Date) -> UNTimeIntervalNotificationTrigger {
        // Return trigger to date provided
        return UNTimeIntervalNotificationTrigger(timeInterval: Date.now.distance(to: date), repeats: false)
    }
    
    func schedule(content: UNMutableNotificationContent, trigger: UNTimeIntervalNotificationTrigger) {
        // Build a notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // Add notification request
        UNUserNotificationCenter.current().add(request)
    }
    
}
