//
//  HistoryModel.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

struct HistoryModel: Codable {
    let date: String
    var enrites: [EntryModel]
    
    init(date: String) {
        self.date = date
        self.enrites = []
    }
    
    init(date: String, entry: EntryModel  ) {
        self.date = date
        self.enrites = [entry]
    }
    
    mutating func addEntry(_ model: EntryModel) {
        self.enrites.append(model)
    }
}
