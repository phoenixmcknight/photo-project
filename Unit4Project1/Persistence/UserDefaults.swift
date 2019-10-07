//
//  UserDefaults.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/7/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation


struct UserDefaultsWrapper {
    static let shared = UserDefaultsWrapper()
    
    func store(isDarkModeOn:Bool) {
        UserDefaults.standard.set(isDarkModeOn, forKey: darkModeOn)
    }
    func getDarkModeBool() -> Bool? {
      return  UserDefaults.standard.value(forKeyPath: darkModeOn) as? Bool
    }
    
    
    private let darkModeOn = "darkModeOn"
}
