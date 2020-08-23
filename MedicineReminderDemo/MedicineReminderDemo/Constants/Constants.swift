//
//  Constants.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

enum Constants {
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let TIME_FORMAT = "hh:mm a"
    static let TIME_AM_SYMBOL = "am"
    static let TIME_PM_SYMBOL = "pm"
    
    static let MORNING_SCORE = 30
    static let AFTERNOON_SCORE = 30
    static let EVENING_SCORE = 40
    
    static let LOW_SCORE = 30
    static let HIGH_SCORE = MORNING_SCORE + AFTERNOON_SCORE + EVENING_SCORE
    
    static let MORNING_HR_TIMEOUT = 11
    static let AFTERNOON_HR_TIMEOUT = 14
    static let EVENING_HR_TIMEOUT = 20
}
