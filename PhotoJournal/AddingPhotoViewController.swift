//
//  AddingPhotoViewController.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 5/1/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import AVFoundation

// step 1 create protocol that takes in model

protocol PhotoDel: AnyObject{
    func modelTake(image: Image)
    
}

class AddingPhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    public var image: Image?
    public var images = [Image?]()
    public var indexPath: Int?
    
    weak var delegate: PhotoDel?
    private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    private var selectedImage: UIImage?{
        didSet{
            imageView.image = selectedImage
        }
    }
    
    private var selectText: String?{
        didSet{
            textView.text = selectText
        }
    }
    
    
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            
            print("editing object")
        } else {
            print("new object")
        }
        textView.delegate = self
        imagePickerController.delegate = self
        camCheck()
    }
    
    
    @IBOutlet weak var camButtonOutlet: UIBarButtonItem!
    
    
    func camCheck(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            showAlert(title: "No Camera", message: "Camera is not available")
            camButtonOutlet.isEnabled = false
        }
    }
    
    //    private func addImageIndexPath(indexPath: Int){
    //        do{
    //            try dataPersistence.create(item: <#T##Image#>)
    //        }
    //    }
    
    private func appendNewPicToCollection(){
        if let image = image{
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
            let imageObject = Image(imageData: resizedImageData, date: Date(), descript: selectText ?? "")
            delegate?.modelTake(image: imageObject)
                    images.insert(imageObject, at: indexPath!)
//            let indexPath = IndexPath(row:0, section: 0)
            //        collectionView.insertItems(at: [indexPath])
            do{
                try dataPersistence.create(item: imageObject, indexPath: indexPath!)
            } catch {
                print("saving error \(error)")
            }
        } else {
            
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
            let imageObject = Image(imageData: resizedImageData, date: Date(), descript: selectText ?? "")
            delegate?.modelTake(image: imageObject)
            //        images.insert(imageObject, at: 0)
            let indexPath = IndexPath(row:0, section: 0)
            //        collectionView.insertItems(at: [indexPath])
            do{
                try dataPersistence.create(item: imageObject, indexPath: indexPath.row)
            } catch {
                print("saving error \(error)")
            }
        }
        dismiss(animated: true)
    }
    
    
    @IBAction func photoLibraryButton(_ sender: UIBarButtonItem) {
        print("im hereeee")
        _ = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        _ = UIAlertAction(title: "Photo Library", style: .default){
            [weak self]  alertAction in
            self?.imagePickerController.sourceType = .photoLibrary
        }
        present(imagePickerController, animated: true)
    }
    
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        _ = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        _ = UIAlertAction(title: "Camera", style: .default){
            [weak self]  alertAction in
            self?.imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let image = image{
            do{
                try dataPersistence.delete(event: indexPath!)
            } catch {
                print("deleting error \(error)")
            }
            appendNewPicToCollection()
        } else {
            appendNewPicToCollection()
        }
        dismiss(animated: true)
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

extension AddingPhotoViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        selectText = textView.text
        print(selectText!)
    }
    
}
