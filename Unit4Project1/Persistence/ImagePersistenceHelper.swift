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
    
    func savePhoto(photo:PhotoWrapper) throws {
        try persistenceHelper.save(newElement: photo)
    }
    func getPhoto() throws -> [PhotoWrapper] {
      return try persistenceHelper.getObjects()
    }
    
    func deleteFunction(withID: String) throws {
           do {
               let photos = try getPhoto()
            let newPhotos = photos.filter { $0.createDate != withID }
               try persistenceHelper.replace(elements: newPhotos)
           }
       }
    
    func editFunction(tag:Int) throws -> PhotoWrapper {
        do {
            var newphoto = try getPhoto()[tag]
          
            
            
           return newphoto

        }
    }
    func savePhoto2(photo:PhotoWrapper,tag:Int) throws {
        try persistenceHelper.save(newElement: photo)
     }
}
