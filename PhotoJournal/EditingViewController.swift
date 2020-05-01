//
//  EditingViewController.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 1/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import AVFoundation

class EditingViewController: UIViewController {
    
    private let imagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
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
    }
    
    
    
}
