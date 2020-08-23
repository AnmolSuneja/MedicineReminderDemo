//
//  ViewExtension.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

extension UIView {
    func applyCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func applyCardLayout() {
        applyCornerRadius(UIConstants.CARD_CORNER_RADIUS)
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.3
    }
}
