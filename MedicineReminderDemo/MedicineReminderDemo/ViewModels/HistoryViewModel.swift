//
//  HistoryViewModel.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

class HistoryViewModel {
    
    var loadDataOnUI: (() -> ())?
    var historyData: [HistoryModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.loadDataOnUI?()
            }
        }
    }

    func loadHistoryData() {
        historyData = Tracker.getAllHistory().all
    }
        
    func numberOfModels(section: Int) -> Int {
        return historyData.count
    }
    
    func height(indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func getHistoryModel(indexPath: IndexPath) -> HistoryModel {
        return historyData[indexPath.row]
    }

}
