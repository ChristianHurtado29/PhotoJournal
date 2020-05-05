//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 1/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import ImageKit
import AVFoundation
import DataPersistence

class InitialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var images = [Image]()
    
    private let imagePickerController = UIImagePickerController()
    
    private let dataPersistence = PersistenceHelper(filename: "images.plist")
    
    private var selectedImage: UIImage?{
        didSet{
           appendNewPicToCollection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        imagePickerController.delegate = self
        loadImages()
    }
    
    private func loadImages() {
        do{
            images = try dataPersistence.loadEvents()
            print(images.count)
        } catch {
            print("loading events error: \(error)")
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
        let imageObject = Image(imageData: resizedImageData, date: Date(), descript: "")
        images.insert(imageObject, at: 0)
        let indexPath = IndexPath(row:0, section: 0)
        collectionView.insertItems(at: [indexPath])
        do{
            try? dataPersistence.create(item: imageObject)
        } catch {
            print("saving error \(error)")
        }
    }
    
    
    
//    @IBAction func photoLibraryButton(_ sender: UIBarButtonItem) {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//
//            imagePickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
//
//            imagePickerController.sourceType = .photoLibrary
//
//            self.present(imagePickerController, animated: true)//, animated: true, completion: nil)
//        }
//    }
//
//
//    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
//    }
    
    @IBAction func segueButton(_ sender: UIBarButtonItem){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil),
        guard let addVC = storyboard?.instantiateViewController(identifier: "AddingPhotoViewController") as? AddingPhotoViewController else {
            fatalError("could not downcast")
        }
        addVC.delegate = self
        present(addVC, animated: true)
    }
    
    @IBAction func editButton(_ sender: UIButton){
        guard let editElip = storyboard?.instantiateViewController(identifier: "EditingViewController") as? EditingViewController else {
            fatalError("couldn't downcast to editvc")
        }
        present(editElip, animated: true)
    }
}

extension InitialViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // step 4 - creating custom delegation - must have an instance of object B
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("could not downcast to an ImageCell")
        }
        let imageObject = images[indexPath.row]
        // step 5: creating delegation - set delegate object
        // similar to tableVIew.delegate = self
        cell.delegate = self as? ImageCellDelegate
        cell.configureCell(imageObject: imageObject)
        return cell
    }
}

extension InitialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.80
        return CGSize(width: itemWidth, height: itemWidth * 1.50)
    }
    
    
}

extension InitialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image was not selected")
            return
        }
        selectedImage = image
        imageView.image = image
        dismiss(animated: true)
    }
    
    
}


extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension InitialViewController: PhotoDel{
    func modelTake(image: Image) {
        images.append(image)
    }
    
    
}
