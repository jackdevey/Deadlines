////
////  NotificationsManager.swift
////  Deadlines
////
////  Created by Jack Devey on 06/01/2023.
////
//
//import Foundation
//import UserNotifications
//
//struct NotificationsManager {
//    
//    let notificationsCenter = UNUserNotificationCenter.current()
//    
//    func askForPermission(accepted: (() -> Void)? = nil, rejected: (() -> Void)? = nil) {
//        // Request permissions for notifications
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            // If permission granted
//            if success {
//                // Run accepted function (if
//                // exists)
//                if let accepted = accepted {
//                    accepted()
//                }
//            } else if let error = error {
//                // Log error
//                print(error.localizedDescription)
//                // Run rejected function (if
//                // exists)
//                if let rejected = rejected {
//                    rejected()
//                }
//            }
//        }
//    }
//    
//    /**
//     Schedule all notifications for a deadline
//     */
//    
//    func scheduleDeadlineNotifications(deadline: Item) {
//        scheduleDeadlineDueNowAlert(deadline: deadline)
//        scheduleDeadlineDueIn30MinsAlert(deadline: deadline)
//        scheduleDeadlineDueIn1DayAlert(deadline: deadline)
//    }
//    
//    /**
//     Remove all notifications for a deadline
//     */
//    
//    func removeDeadlineNotifications(deadline: Item) {
//        removeDeadlineDueNowAlert(deadline: deadline)
//        removeDeadlineDueIn30MinsAlert(deadline: deadline)
//        removeDeadlineDueIn1DayAlert(deadline: deadline)
//    }
//    
//    func scheduleDeadlineDueNowAlert(deadline: Item) {
//        // Create the notification
//        let content = setContent(title: deadline.name!, subtitle: "Due in now")
//        // Set trigger to deadline due date
//        let trigger = triggerToDate(date: deadline.date!)
//        // Schedule the notification
//        schedule(identifier: "\(deadline.id!).now", content: content, trigger: trigger)
//    }
//    
//    func removeDeadlineDueNowAlert(deadline: Item) {
//        // Remove notification for now
//        return remove(identifiers: ["\(deadline.id!).now"])
//    }
//    
//    func scheduleDeadlineDueIn30MinsAlert(deadline: Item) {
//        // If deadline is due in less than 30 minutes
//        if deadline.date! - (30 * 60) < Date.now {
//            return
//        }
//        // Create the notification
//        let content = setContent(title: deadline.name!, subtitle: "Due in 30 minutes")
//        // Set trigger to deadline due date
//        let trigger = triggerToDate(date: deadline.date! - (30 * 60))
//        // Schedule the notification
//        schedule(identifier: "\(deadline.id!).30mins", content: content, trigger: trigger)
//    }
//    
//    func removeDeadlineDueIn30MinsAlert(deadline: Item) {
//        // Remove notification for 30 minutes
//        return remove(identifiers: ["\(deadline.id!).30mins"])
//    }
//    
//    func scheduleDeadlineDueIn1DayAlert(deadline: Item) {
//        // If deadline is due in less than
//        if deadline.date! - (60 * 60 * 24) < Date.now {
//            return
//        }
//        // Create the notification
//        let content = setContent(title: deadline.name!, subtitle: "Due tomorrow")
//        // Set trigger to deadline due date
//        let trigger = triggerToDate(date: deadline.date! - (60 * 60 * 24))
//        // Schedule the notification
//        schedule(identifier: "\(deadline.id!).1day", content: content, trigger: trigger)
//    }
//    
//    func removeDeadlineDueIn1DayAlert(deadline: Item) {
//        // Remove notification for 1 day
//        return remove(identifiers: ["\(deadline.id!).1day"])
//    }
//    
//    func setContent(title: String, subtitle: String, sound: UNNotificationSound = UNNotificationSound.default) -> UNMutableNotificationContent {
//        // Create notification content
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.subtitle = subtitle
//        content.sound = sound
//        // Return content
//        return content
//    }
//    
//    func triggerToDate(date: Date) -> UNTimeIntervalNotificationTrigger {
//        // Return trigger to date provided
//        return UNTimeIntervalNotificationTrigger(timeInterval: Date.now.distance(to: date), repeats: false)
//    }
//    
//    func schedule(identifier: String, content: UNMutableNotificationContent, trigger: UNTimeIntervalNotificationTrigger) {
//        // Build a notification request
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//        // Add notification request
//        notificationsCenter.add(request)
//    }
//    
//    func remove(identifiers: [String]) {
//        // Remove notifications with identifier
//        notificationsCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
//    }
//    
//}
