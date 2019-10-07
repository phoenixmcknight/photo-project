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
    
    func store(setMessage:String) {
        UserDefaults.standard.set(setMessage, forKey: message)
    }
    
    
    private let message = "message"
}
