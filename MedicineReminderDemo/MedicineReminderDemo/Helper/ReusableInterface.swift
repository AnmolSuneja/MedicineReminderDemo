//
//  ReusableInterface.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import Foundation

protocol ReusableInterface {
    static var reuseIdentifier: String {get}
}

extension ReusableInterface {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
