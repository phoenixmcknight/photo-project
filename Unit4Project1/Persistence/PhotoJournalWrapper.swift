//
//  PhotoJournalWrapper.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/3/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation




struct PhotoWrapper:Codable {
    let createDate:String
    let message:String
    let picture:Data
}
