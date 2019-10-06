//
//  ChangesEditOrAdd.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/4/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation

enum Changes:String {
    case add = "add"
    case edit = "edit"
    
  
}

struct Edit {

    static let shared = Edit()
    
    func startMessage(changes: Changes,tag:Int) -> String {
        switch changes {
        case .add:
            return ""
        case .edit:
            let message = try? PhotoPersistenceManager.manager.getPhoto()[tag]
            if let messageFromPhoto = message {
                return messageFromPhoto.message
            } else {
                return ""
            }
        }
    
    }
}

