//
//  ViewController.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 9/27/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class InitialPhotoViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        
        if #available(iOS 13.0, *) {
            if  let newImageStoryBoard = storyboard?.instantiateViewController(identifier: "ViewControllerNewImage") as? ViewControllerNewImage {
                
                self.present(newImageStoryBoard, animated: true,completion: nil)
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
}

