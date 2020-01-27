//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 1/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var images = [Images]()
    
    private let imagePickerController = UIImagePickerController()
    
    private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    private var selectedImage: UIImage?{
    didSet{
        appendNewPhotoToCollection()
    }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }




private func appendNewPhotoToCollection(){
       guard let image = selectedImage,
           let imageData = image.jpegData(compressionQuality: 1.0) else{
               print("image is nil")
               return
       }
}
}
