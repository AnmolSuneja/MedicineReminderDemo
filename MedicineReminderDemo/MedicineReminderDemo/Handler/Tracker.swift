//
//  Tracker.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

enum TrackerError: Error {
    case runtimeError(String)
}

struct Tracker {
    private static func getEntryModelDetails(dayEntries: [EntryModel]) -> (message: String?, day: String,time: String, score:Int, dayTime: DayTime, schduleAllNotifications: Bool) {
        //apply a check that 3 entries done h to you are done for day
        let dayEntriesCount = dayEntries.count
        var notifyUser: String?
        if dayEntriesCount == 3 {
            //Course done for day
            notifyUser = TextConstants.MEDICINE_COURSE_COMPLETED
        }
        
        let date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        dateFormatter.dateFormat = Constants.DATE_FORMAT
        let day = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = Constants.TIME_FORMAT
        dateFormatter.amSymbol = Constants.TIME_AM_SYMBOL
        dateFormatter.pmSymbol = Constants.TIME_PM_SYMBOL
        let time = dateFormatter.string(from: date)

        
        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: date))!
        var dayTime = DayTime.evening
        var score = Constants.EVENING_SCORE
        switch hour {
        //Timing for morning medicine
        case 4 ... (Constants.MORNING_HR_TIMEOUT - 1):
            if dayEntriesCount == 0 {
                dayTime = DayTime.morning
            } else {
                notifyUser = TextConstants.WAIT_TILL_AFTERNOON
            }
        case Constants.MORNING_HR_TIMEOUT:
            if dayEntriesCount == 0 {
                //Timing for morning medicine in case user take medicine after reminder
                dayTime = DayTime.morning
            } else {
                fallthrough
            }
        case (Constants.MORNING_HR_TIMEOUT + 1) ... (Constants.AFTERNOON_HR_TIMEOUT - 1):
            if dayEntriesCount == 0 {
                //Timing for afternoon medicine
                dayTime = DayTime.afternoon
            } else if dayEntriesCount == 1 {
                if DayTime(rawValue: dayEntries[0].dayTime)! == .morning {
                    dayTime = DayTime.afternoon
                } else {
                    notifyUser = TextConstants.WAIT_TILL_EVENING
                }
            } else {
                notifyUser = TextConstants.WAIT_TILL_EVENING
            }
        case Constants.AFTERNOON_HR_TIMEOUT:
            if dayEntriesCount == 0 {
                //Timing for afternoon medicine  in case user take medicine after reminder
                dayTime = DayTime.afternoon
            } else if dayEntriesCount == 1 {
                let timeOfDay = DayTime(rawValue: dayEntries[0].dayTime)!
                if timeOfDay == .morning {
                    dayTime = DayTime.afternoon
                } else {
                    fallthrough
                }
            } else {
                fallthrough
            }
        default:
            if dayEntriesCount == 0 {
                //Timing for evening medicine
                dayTime = DayTime.evening
            } else if dayEntriesCount == 1 {
                let timeOfDay = DayTime(rawValue: dayEntries[0].dayTime)!
                if timeOfDay != .evening {
                    dayTime = DayTime.evening
                } else {
                    notifyUser = TextConstants.MEDICINE_COURSE_COMPLETED
                }
            } else if dayEntriesCount == 2 {
                let timeOfDay = DayTime(rawValue: dayEntries[1].dayTime)!
                if timeOfDay != .evening {
                    dayTime = DayTime.evening
                } else {
                    notifyUser = TextConstants.MEDICINE_COURSE_COMPLETED
                }
            } else {
                notifyUser = TextConstants.MEDICINE_COURSE_COMPLETED
            }
        }
        
        var schduleAllNotifications = false
        if notifyUser == nil {
            switch dayTime {
            case .morning:
                score = Constants.MORNING_SCORE
                if hour == Constants.MORNING_HR_TIMEOUT {
                    schduleAllNotifications = true
                }
            case .afternoon:
                score = Constants.AFTERNOON_SCORE
                if hour == Constants.AFTERNOON_HR_TIMEOUT {
                    schduleAllNotifications = true
                }
            default:
                score = Constants.EVENING_SCORE
                if hour <= 4 || hour >= Constants.EVENING_HR_TIMEOUT {
                    schduleAllNotifications = true
                }
            }
        }
        return (notifyUser, day, time, score, dayTime,schduleAllNotifications)
    }
            
    static func medicineTaken() throws -> (dayTime: DayTime, schduleAllNotifications: Bool) {
        let data = getAllHistory()
        var todayModel = data.today
        var history = data.all
        
        let model = getEntryModelDetails(dayEntries: todayModel.enrites)
        if model.message != nil {
            throw TrackerError.runtimeError(model.message!)
        }
        let entryModel = EntryModel(time: model.time, score: model.score, dayTime: model.dayTime.rawValue)
        todayModel.addEntry(entryModel)
        history[0] = todayModel
        
        Storage.saveHistory(history)
        return (DayTime(rawValue: todayModel.enrites.last!.dayTime)!, model.schduleAllNotifications)
    }
    
    static func getAllHistory() -> (today: HistoryModel, all: [HistoryModel]) {
        let date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        dateFormatter.dateFormat = Constants.DATE_FORMAT
        let day = dateFormatter.string(from: date)
        
        var history = Storage.getHistory()
        //Check if this day has been recorded
        let data = history.first
        if data == nil || data!.date != day  {
            //Today day not recorded
            //Record it
            var startDate = Date()
            if let lastCapturedHistory = history.first {
                startDate = dateFormatter.date(from: lastCapturedHistory.date)!
                startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
            }
            
            let endDate = Date()
            while startDate <= endDate {
                let historyModel = HistoryModel(date: dateFormatter.string(from: startDate))
                history.insert(historyModel, at: 0)
                
                startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
            }
            Storage.saveHistory(history)
        }
        return (history.first!, history)
    }
}
