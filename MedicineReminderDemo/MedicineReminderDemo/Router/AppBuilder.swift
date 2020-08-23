//
//  AppBuilder.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

struct AppBuilder {
    
    private init() {}
    
    static func getAlert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: TextConstants.DISMISS_ALERT_TITLE, style: .cancel, handler: nil)
        alert.addAction(action)
        
        return alert
    }
    
    static func getHistoryViewController() -> HistoryViewController? {
        let storyboard = UIStoryboard(name: StoryboardName.main, bundle: Bundle.main)
        
        guard let historyVC = storyboard.instantiateViewController(withIdentifier: HistoryViewController.reuseIdentifier) as? HistoryViewController else {
            return nil
        }
        
        return historyVC
    }
}
