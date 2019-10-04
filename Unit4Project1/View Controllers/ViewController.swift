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
    var photos = [PhotoWrapper]() {
        didSet {
            collectionViewOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //loadPhotos()
        setUP()
        collectionViewOutlet.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        loadPhotos()
        
        collectionViewOutlet.reloadData()
        print("loading")
    }
    private func loadPhotos() {
           do {
               photos = try

                   PhotoPersistenceManager.manager.getFilm()
               collectionViewOutlet.reloadData()
               print("loading")

           } catch {
               print(error)
           }
       }

    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        
            if  let newImageStoryBoard = storyboard?.instantiateViewController(identifier: "ViewControllerNewImage") as? ViewControllerNewImage {
                
                self.present(newImageStoryBoard, animated: true,completion: nil)
            }
        }
        var pickImageFunctionColors: (()->()) = {}

    
    func setUP() {
        collectionViewOutlet.delegate = self
        
        collectionViewOutlet.dataSource = self
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

        cell.dateCreatedLabel.text = photosPath.createDate
        cell.descriptionLabel.text = photosPath.message
        cell.backgroundColor = colorGenerator()
        cell.delegate = self
        return cell
    }
    func colorGenerator() -> UIColor{
       
        colors = RGBValue()
     return   colors.createRGBColor()
    }
    
   
}
extension InitialPhotoViewController:InitialViewControllerCollectionViewCellCellDelegate {
    func actionSheet(tag: Int) {
        let optionmenu = UIAlertController(title: "Options", message: "Choose option", preferredStyle: .actionSheet)

        let deleteFilmAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            let photo = self.photos[tag]
            
         try?   PhotoPersistenceManager.manager.deleteFavorite(withID: photo.createDate)
            self.loadPhotos()
           
            
        }
        let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
            let image = UIImage(data: self.photos[tag].picture)
            let share = UIActivityViewController(activityItems: [image!], applicationActivities: [])
            self.present(share, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionmenu.addAction(deleteFilmAction)
        optionmenu.addAction(cancelAction)
        optionmenu.addAction(shareAction)
        self.present(optionmenu, animated: true, completion: nil)
    }


}
