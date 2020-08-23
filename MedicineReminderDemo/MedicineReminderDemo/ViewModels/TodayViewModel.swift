//
//  TodayViewModel.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

class TodayViewModel {
    var loadDataOnUI: (() -> ())?
    var updateMedicineLog: ((Bool, String) -> ())?
    
    var todayScore: Int = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.loadDataOnUI?()
            }
        }
    }
    
    func getGreetingText() -> String {
        let cal = Calendar.current
        let hour = cal.dateComponents([.hour], from: Date()).hour!
        switch hour {
        case 4 ... 11:
            return TextConstants.MORNING_GREET
        case 12 ... 15:
            return TextConstants.AFTERNOON_GREET
        default:
            return TextConstants.EVENING_GREET
        }
    }
    
    func updateTodayScore() {
        todayScore = Tracker.getAllHistory().today.enrites.map{$0.score}.reduce(0,+)
    }
    
    func getTodayScore() -> Int {
        return todayScore
    }
    
    func getScoreColor() -> UIColor {
        return Utility.getScoreBasedColor(todayScore)
    }
    
    //MARK: Actions
    func takeMedicine() {
        do {
            let data = try Tracker.medicineTaken()
            updateTodayScore()
            updateMedicineLog?(true,"\(data.dayTime.rawValue.capitalized) \(TextConstants.MEDICINE_INTAKE_CAPTURED)" )
            
            var schduleNotificationForTime: [DayTime] = []
            for dayTime in DayTime.allCases {
                if data.dayTime != dayTime {
                    schduleNotificationForTime.append(dayTime)
                }
            }
            if data.schduleAllNotifications {
                schduleNotificationForTime = DayTime.allCases
            }
            NotificationHandler.reschduleNotification(schduleNotificationForTime)
        } catch TrackerError.runtimeError(let message) {
            updateMedicineLog?(false, message)
        } catch {
            print("Exception occured")
        }
    }
}
