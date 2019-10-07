//
//  darkModeSettings.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/7/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

enum DarkModeOnOrOff {
    case on
    case off
}

struct ScrollingSettings {

static func scrollingNumber(direction:String) -> Int {
   
    switch direction {
    case "horizontal":
        return 1
    case "vertical":
        return 0
    default:
        return -1
    }
}
}
