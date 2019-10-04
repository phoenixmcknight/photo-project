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

    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        
            if  let newImageStoryBoard = storyboard?.instantiateViewController(identifier: "ViewControllerNewImage") as? ViewControllerNewImage {
                
                self.present(newImageStoryBoard, animated: true,completion: nil)
            }
        }
        
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
        
      
  cell.InititalViewControllerImage.image = UIImage(data: photosPath.picture)
        
        cell.dateCreatedLabel.text = photosPath.createDate
        cell.descriptionLabel.text = photosPath.message
        return cell
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
}
