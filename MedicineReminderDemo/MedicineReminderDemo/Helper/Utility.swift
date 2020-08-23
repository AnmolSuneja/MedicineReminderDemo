//
//  Utility.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

struct Utility {
        
    static func getScoreBasedColor(_ score: Int) -> UIColor {
        if score == Constants.HIGH_SCORE {
            return UIConstants.HIGH_SCORE_COLOR
        } else if score <= Constants.LOW_SCORE {
            return UIConstants.LOW_SCORE_COLOR
        } else {
            return UIConstants.GOOD_SCORE_COLOR
        }
    }
}
