//
//  AppRouter.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

struct AppRouter {
    
    static func showAlert(title: String?, message: String?, from viewController: UIViewController) {
        let alert = AppBuilder.getAlert(title: title, message: message)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func pushHistoryViewController(from parent: UINavigationController) {
        guard let vc = AppBuilder.getHistoryViewController() else {
            return
        }
        parent.pushViewController(vc, animated: true)
    }
}
