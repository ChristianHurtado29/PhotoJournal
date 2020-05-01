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
    
    private var selectedImage: UIImage?{
        didSet{
            imageView.image = selectedImage
            //appendNewPicToCollection()
        }
    }
    
    var imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var camButtonOutlet: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        camCheck()
        imagePickerController.delegate = self
    }
    
    
    func camCheck(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            showAlert(title: "No Camera", message: "Camera is not available")
            camButtonOutlet.isEnabled = false
        }
    }
    
    private func appendNewPicToCollection(){
        guard let image = selectedImage,
            let imageData = image.jpegData(compressionQuality: 1.0) else {
                print("image is nil")
                return
        }
        print("Image size is \(image.size)")
        let size = UIScreen.main.bounds.size
        
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        print("resized image is now \(resizedImage.size)")
        
        guard let resizedImageData = resizedImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        let imageObject = Image(imageData: resizedImageData, date: Date(), description: "")
        
//        images.insert(imageObject, at: 0)
        
        let indexPath = IndexPath(row:0, section: 0)
        
//        collectionView.insertItems(at: [indexPath])
        
        do{
            try? dataPersistence.create(item: imageObject)
        } catch {
            print("saving error \(error)")
        }
    }

    
    @IBAction func photoLibraryButton(_ sender: UIBarButtonItem) {
        print("im hereeee")
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
        appendNewPicToCollection()
    }
    
    
    

}

extension AddingPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image selection failed")
            return
        }
        selectedImage = image

        
        dismiss(animated: true)
    }
}
