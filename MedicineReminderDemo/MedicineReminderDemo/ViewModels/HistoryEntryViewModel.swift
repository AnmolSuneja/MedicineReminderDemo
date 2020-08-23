
//
//  HistoryEntryViewModel.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

class HistoryEntryViewModel {
    
    private let totalScore: Int
    let history: HistoryModel
    
    init(history: HistoryModel) {
        self.history = history
        totalScore = history.enrites.map{$0.score}.reduce(0,+)
    }
    
    func getScore() -> Int {
        return totalScore
    }
        
    func getScoreColor() -> UIColor {
        return Utility.getScoreBasedColor(totalScore)
    }
    
    func getDate() -> String {
        return history.date
    }
    
    func getFirstEntryOfDay() -> EntryModel? {
        if !history.enrites.isEmpty {
            return history.enrites[0]
        }
        return nil
    }
    
    func getSecondEntryOfDay() -> EntryModel? {
        if history.enrites.count > 1 {
            return history.enrites[1]
        }
        return nil
    }
    
    func getThirdEntryOfDay() -> EntryModel? {
        if history.enrites.count > 2 {
            return history.enrites[2]
        }
        return nil
    }
}
