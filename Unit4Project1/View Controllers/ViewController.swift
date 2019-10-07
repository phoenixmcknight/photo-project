//
//  ViewController.swift
//  Unit4Project1
//
//  Created by Phoenix McKnight on 9/27/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class InitialPhotoViewController: UIViewController {

   // add button fuction random color
    @IBOutlet  var collectionViewOutlet: UICollectionView!
   var colors = RGBValue()
    
     var darkModeIsOn:Bool? {
        didSet {
            self.darkModeIsOn! ? darkModeOn() : darkModeOff()
        }
    }
   

    
    var photos = [PhotoWrapper]() {
        didSet {
            collectionViewOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        navigationItem.title = "Photos"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        loadPhotos()
        
        if UserDefaultsWrapper.shared.getDarkModeBool() != nil {
        darkModeIsOn = UserDefaultsWrapper.shared.getDarkModeBool()
        }
        collectionViewOutlet.reloadData()
        
    }
    private func loadPhotos() {
           do {
               photos = try

                   PhotoPersistenceManager.manager.getPhoto()
               collectionViewOutlet.reloadData()
               print("loading")

           } catch {
               print(error)
           }
       }
    
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
   
        let settingsVC = storyboard?.instantiateViewController(identifier: "setttingsViewController") as! setttingsViewController
        
        navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    
    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        
            if  let newImageStoryBoard = storyboard?.instantiateViewController(identifier: "ViewControllerNewImage") as? ViewControllerNewImage {
                
                newImageStoryBoard.addOrEdit = Changes.add
                newImageStoryBoard.modalPresentationStyle = .currentContext
                
                self.present(newImageStoryBoard, animated: true,completion: nil)
            }
        }
        var pickImageFunctionColors: (()->()) = {}

    
    func setUP() {
        collectionViewOutlet.delegate = self
        
        collectionViewOutlet.dataSource = self
    }
    func darkModeOn() {
        collectionViewOutlet.backgroundColor = .black
    }
    func darkModeOff() {
        collectionViewOutlet.backgroundColor = .opaqueSeparator
       
    }
    
}
extension InitialPhotoViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let photosPath = photos[indexPath.item]
        let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! InitialViewControllerCollectionViewCell
      
        cell.buttonOutlet.tag = indexPath.item
        
        
        
  cell.InititalViewControllerImage.image = UIImage(data: photosPath.picture)
        CustomLayer.shared.createCustomlayer(layer: cell.layer)
        cell.dateCreatedLabel.text = photosPath.createDate
        cell.descriptionLabel.text = photosPath.message
        cell.backgroundColor = colorGenerator()
        cell.delegate = self
       
        cell.changeColorOfBorderCellFunction = {
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.shadowColor = UIColor.white.cgColor
        }
        
        if darkModeIsOn == true {
            cell.changeColorOfBorderCellFunction()
        }
        return cell
    }
    func colorGenerator() -> UIColor{
       
        colors = RGBValue()
     return   colors.createRGBColor()
    }
    
//    func flowLayout() {
//        if let flowLayout = collectionViewOutlet.layout as? UICollectionViewFlowLayout { flowLayout.scrollDirection = .horizontal }
//    }
   
}
extension InitialPhotoViewController:InitialViewControllerCollectionViewCellCellDelegate {
    func actionSheet(tag: Int) {
        let optionmenu = UIAlertController(title: "Options", message: "Choose option", preferredStyle: .actionSheet)

        let deleteFilmAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            let photo = self.photos[tag]
         
            self.photos.remove(at: tag)

         try?   PhotoPersistenceManager.manager.deleteFunction(withID: photo.createDate)
        }
        let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
            let image = UIImage(data: self.photos[tag].picture)
            let share = UIActivityViewController(activityItems: [image!], applicationActivities: [])
            self.present(share, animated: true, completion: nil)
        }
        let editAction = UIAlertAction(title: "Edit", style: .destructive) { (action) in
            if  let newImageStoryBoard = self.storyboard?.instantiateViewController(identifier: "ViewControllerNewImage") as? ViewControllerNewImage {
                
                newImageStoryBoard.addOrEdit = .edit
                newImageStoryBoard.currentTag = tag
                newImageStoryBoard.passingInfoPhotos = self.photos
                newImageStoryBoard.modalPresentationStyle = .currentContext
                
                self.present(newImageStoryBoard, animated: true,completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionmenu.addAction(deleteFilmAction)
        optionmenu.addAction(cancelAction)
        optionmenu.addAction(shareAction)
        optionmenu.addAction(editAction)
        self.present(optionmenu, animated: true, completion: nil)
    }
    

}

