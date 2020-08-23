//
//  Storage.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

struct Storage {
    static func getHistory() -> [HistoryModel] {
        return UserDefaults.standard.getObject(forKey: UserDefaults.Keys.History_Storage, castTo: [HistoryModel].self) ?? []
    }
    
    static func saveHistory(_ history: [HistoryModel]) {
        UserDefaults.standard.setObject(history, forKey: UserDefaults.Keys.History_Storage)
    }
}

extension UserDefaults {
    enum Keys {
        static let History_Storage = "Reminder_Demo_History_Storage"
    }
    
    func setObject<Object>(_ object: Object, forKey: String) where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            print("Error occured while encoding")
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) -> Object? where Object: Decodable {
        guard let data = data(forKey: forKey) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            print("Error occured while decoding")
            return nil
        }
    }
}
