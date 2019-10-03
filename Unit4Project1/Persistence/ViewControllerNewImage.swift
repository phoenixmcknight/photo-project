//
//  ViewControllerNewImage.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 10/3/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerNewImage:UIViewController {
   
    @IBOutlet weak var textFieldDescription: UITextField!
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageOutlet.image = UIImage(named: "image")
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)    }

    @IBAction func photoLibrary(_ sender: UIBarButtonItem) {
   let imagePicker = UIImagePickerController()

                   imagePicker.sourceType = .photoLibrary
                   imagePicker.allowsEditing = true
                   imagePicker.delegate = self
              self.present(imagePicker,animated: true,completion: nil)
                //{
//                  try? ImagePersistenceHelper.manager.save(newImage: self.randomUser[indexPath.row])
                  //Save to file manager
              
        
    
    }
}
    
extension ViewControllerNewImage: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image :(
            return
        }
        imageOutlet.image = image
        
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }

  
}
