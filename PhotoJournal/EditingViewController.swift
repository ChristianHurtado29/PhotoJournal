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
    
    private var selectedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }
    
    
    
}

extension EditingViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image selection failed")
            return
        }
        selectedImage = image
        dismiss(animated: true)
    }
}
