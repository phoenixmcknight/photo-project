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
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var addOrEdit:Changes!
    
    var currentTag:Int! = 0
    
    var textFieldText:String! {
        didSet {
            
            if self.textFieldText != "" && self.textFieldText != nil {
            saveButtonOutlet.isEnabled = true
            } else {
                saveButtonOutlet.isEnabled = false
            }
    }
    }
   
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonOutlet.isEnabled = false
        textFieldDescription.delegate = self
        textFieldDescription.text = Edit.shared.startMessage(changes: addOrEdit, tag: currentTag)
        textFieldText = Edit.shared.startMessage(changes: addOrEdit, tag: currentTag)
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
        
    
    }
    private func currentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
      
        switch addOrEdit {
        case .add:
            let data = imageOutlet.image!.pngData()
                   
                   let photo = PhotoWrapper(createDate: currentDate(), message: textFieldText, picture: data!)
                   
                 try?  PhotoPersistenceManager.manager.savePhoto(photo: photo)
                   print("saving")
        case .edit:
        let photoData = imageOutlet.image!.pngData()
      var newPhoto =  try? PhotoPersistenceManager.manager.editFunction(tag: currentTag)
            
        newPhoto?.message = textFieldText
        newPhoto?.picture = photoData!
        
//        try? PhotoPersistenceManager.manager.deleteFunction(withID: PhotoPersistenceManager.manager.getPhoto()[currentTag].createDate)
   
        let intitalVC = storyboard?.instantiateViewController(identifier: "InitialPhotoViewController") as! InitialPhotoViewController
        
       var photo = try? PhotoPersistenceManager.manager.getPhoto()
        photo?.insert(newPhoto!, at: currentTag )
        photo?.remove(at: currentTag + 1)
        
            
       
            
        intitalVC.photos = photo!
            
       
        default:
           print("failed")
        }
        
       
        dismiss(animated: true, completion: nil)
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
        dismiss(animated: true, completion:nil)
}
}
extension ViewControllerNewImage:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textFieldText = textField.text

        return true
}
  
}
