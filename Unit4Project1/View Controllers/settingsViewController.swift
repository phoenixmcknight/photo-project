//
//  settingsViewController.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/7/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation

import UIKit

class setttingsViewController:UIViewController {
   
    @IBOutlet weak var darkModeIntroLabel: UILabel!
    
    @IBOutlet weak var darkModeOnOrOff: UILabel!
    @IBOutlet weak var scrollingSegmentControll: UISegmentedControl!
    
   
    @IBOutlet weak var UISwitchOutlet: UISwitch!
    
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaultsWrapper.shared.getDarkModeBool() == true {
        UISwitchOutlet.isOn = true
            darkModeOn()
        } else if UserDefaultsWrapper.shared.getDarkModeBool() == false {
            UISwitchOutlet.isOn = false
            darkModeOff()
        }
        setUp()
    }
        
    
    
    
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
    

     
        switch sender.isOn {
        case true:
            UserDefaultsWrapper.shared.store(isDarkModeOn: true)
            darkModeOn()
            UISwitchOutlet.isOn = true
            
        case false:
            UserDefaultsWrapper.shared.store(isDarkModeOn: false)
            
            darkModeOff()
            UISwitchOutlet.isOn = false

        }
    }
   
    func darkModeOn() {
        darkModeIntroLabel.textColor = .white
        view.backgroundColor = .black
        darkModeOnOrOff.text = "Dark Mode is ON"
        darkModeOnOrOff.textColor = .white
        scrollingSegmentControll.backgroundColor = .white
}
    func darkModeOff() {
        darkModeIntroLabel.textColor = .black
        view.backgroundColor = .opaqueSeparator
        darkModeOnOrOff.text = "Dark Mode is OFF"
        darkModeOnOrOff.textColor = .black
        scrollingSegmentControll.backgroundColor = .opaqueSeparator
}
    func setUp() {
        darkModeIntroLabel.text = "Hit the switch to activate/turn off Dark Mode"
        
    }
}
