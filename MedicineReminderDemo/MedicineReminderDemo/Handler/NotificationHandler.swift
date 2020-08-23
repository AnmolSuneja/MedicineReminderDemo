//
//  NotificationHandler.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UserNotifications

struct NotificationHandler {
    enum Keys {
        static let IDENTIFIER_PREFIX = "Reminder"
        static let MORNING_IDENNTIFIER = "\(IDENTIFIER_PREFIX)_Notification_\(DayTime.morning.rawValue)"
        static let AFTERNOON_IDENNTIFIER = "\(IDENTIFIER_PREFIX)_Notification_\(DayTime.afternoon.rawValue)"
        static let EVENING_IDENNTIFIER = "\(IDENTIFIER_PREFIX)_Notification_\(DayTime.evening.rawValue)"
    }
    
    private static func schduleMorningNotification() {
        var notificationDate = DateComponents()
        notificationDate.hour = Constants.MORNING_HR_TIMEOUT
        notificationDate.minute = 0
        schduleLocalNotification(message: TextConstants.MORNING_REMINDER_TEXT,
                                 date: notificationDate,
                                 identifier: NotificationHandler.Keys.MORNING_IDENNTIFIER)
    }
    
    private static func schduleAfternoonNotification() {
        var notificationDate = DateComponents()
        notificationDate.hour = Constants.AFTERNOON_HR_TIMEOUT
        notificationDate.minute = 0
        schduleLocalNotification(message: TextConstants.AFTERNOON_REMINDER_TEXT,
                                 date: notificationDate,
                                 identifier: NotificationHandler.Keys.AFTERNOON_IDENNTIFIER)
    }
    
    private static func schduleEveningNotification() {
        var notificationDate = DateComponents()
        notificationDate.hour = Constants.EVENING_HR_TIMEOUT
        notificationDate.minute = 0
        schduleLocalNotification(message: TextConstants.EVENING_REMINDER_TEXT,
                                 date: notificationDate,
                                 identifier: NotificationHandler.Keys.EVENING_IDENNTIFIER)
    }
    
    static func schduleReminderNotifications() {
        schduleMorningNotification()
        schduleAfternoonNotification()
        schduleEveningNotification()
    }
    
    static func reschduleNotification(_ dayTimes: [DayTime]) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        for dayTime in dayTimes {
            switch dayTime {
            case .morning:
                schduleMorningNotification()
            case .afternoon:
                schduleAfternoonNotification()
            case .evening:
                schduleEveningNotification()
            }
        }
    }
    
    static func schduleLocalNotification(message: String, date: DateComponents, identifier: String) {
        let localNotification = UNMutableNotificationContent()
        localNotification.sound = .default
        localNotification.title = TextConstants.NOTIFICATION_TITLE
        localNotification.body = message
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: localNotification, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Next Notification schduled at: \(String(describing: trigger.nextTriggerDate()))")
            }
        }
    }
}
