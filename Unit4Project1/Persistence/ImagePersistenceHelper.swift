//
//  ImagePersistenceHelper.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/4/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

struct PhotoPersistenceManager {
    
    static let manager = PhotoPersistenceManager()
    
    private let persistenceHelper = PersistenceHelper<PhotoWrapper>(fileName: "photos.plist")
    
    func saveFilm(photo:PhotoWrapper) throws {
        try persistenceHelper.save(newElement: photo)
    }
    func getFilm() throws -> [PhotoWrapper] {
      return try persistenceHelper.getObjects()
    }
}
