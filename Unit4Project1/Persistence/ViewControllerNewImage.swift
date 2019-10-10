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
    //MARK: Outlets
    @IBOutlet weak var textFieldDescription: UITextField!
    
    @IBOutlet weak var newImageOutlet: UIImageView!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    //MARK: Variables
    var addOrEdit:Changes!
    
    var currentTag:Int! = 0
    
    var passingInfoPhotos:[PhotoWrapper]!
    
    var textFieldText:String! {
        didSet {
            saveButtonOutlet.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonOutlet.isEnabled = false
        loadDefaultImage()
        loadTextDescription()
        textFieldDescription.delegate = self
    }
    //MARK: Actions
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        switch addOrEdit {
        case .add:
            let data = newImageOutlet.image!.pngData()
            let photo = PhotoWrapper(createDate: currentDate(), message: textFieldText, picture: data!)
          try?  PhotoPersistenceManager.manager.savePhoto(photo: photo)
        case .edit:
            var newPhoto: PhotoWrapper!
            do { try newPhoto =  PhotoPersistenceManager.manager.editFunction(tag: currentTag)
            } catch {
                print(error)
            }
            if let realphoto = newImageOutlet.image?.pngData() {
                newPhoto.picture = realphoto
            } else {
                newPhoto.picture = (UIImage(named: "image")?.pngData())!
            }
            newPhoto.message = textFieldText != "" ? textFieldText : "No description"
           
            passingInfoPhotos.insert(newPhoto, at: currentTag)
            passingInfoPhotos.remove(at: currentTag + 1)
            
            do{ try PhotoPersistenceManager.manager.replaceAllFunction(newPhoto: passingInfoPhotos) } catch { print(error)
                }
        default:
            return
        }
        dismiss(animated: true, completion: nil)
    }
//MARK:Functions
    func loadTextDescription() {
        textFieldDescription.text = Edit.shared.startMessage(changes: addOrEdit, tag: currentTag)
        textFieldText = Edit.shared.startMessage(changes: addOrEdit, tag: currentTag)
    }
    
    func loadDefaultImage() {
        switch addOrEdit {
        case .edit:
            newImageOutlet.image = UIImage(data: passingInfoPhotos[currentTag].picture)
        case .add:
            newImageOutlet.image = UIImage(named: "image")
            
        default:
            return
        }
    }
    private func currentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
}
//MARK: Extensions
extension ViewControllerNewImage: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image :(
            return
        }
        newImageOutlet.image = image
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}
extension ViewControllerNewImage:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldDescription.resignFirstResponder()
        
        textFieldText = textField.text
        return true
    }
}
