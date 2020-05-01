//
//  AddingPhotoViewController.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 5/1/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import AVFoundation

class AddingPhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    private var selectedImage: UIImage!
    
    var imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func photoLibraryButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
    }
    

}
