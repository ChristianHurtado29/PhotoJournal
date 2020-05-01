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
    
    @IBOutlet weak var camButtonOutlet: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        camCheck()

    }
    
    
    func camCheck(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            showAlert(title: "No Camera", message: "Camera is not available")
            camButtonOutlet.isEnabled = false
        }
    }
    
    @IBAction func photoLibraryButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){
            [weak self]  alertAction in
            self?.imagePickerController.sourceType = .photoLibrary
        }
        present(imagePickerController, animated: true)
    }
    
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            [weak self]  alertAction in
            self?.imagePickerController.sourceType = .camera
        }

        present(imagePickerController, animated: true)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }
    
    
    

}
