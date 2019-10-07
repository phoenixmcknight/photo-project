//
//  InitialViewControllerCollectionViewCell.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/4/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

protocol  InitialViewControllerCollectionViewCellCellDelegate:AnyObject {
    func actionSheet(tag:Int)
    
}

class InitialViewControllerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var
    InititalViewControllerImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    @IBOutlet weak var initialViewControllerButtonOutlet: UIButton!
    
    weak var delegate:InitialViewControllerCollectionViewCellCellDelegate?
    
     var changeColorOfBorderCellFunction: (()->()) = {}
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func actionButton(_ sender: UIButton) {
        delegate?.actionSheet(tag: sender.tag)
    }
    
    
}

