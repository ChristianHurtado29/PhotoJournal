//
//  ImageCell.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 1/27/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
    
    func didLongPress(_ imageCell: ImageCell)
}

class ImageCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    weak var delegate: ImageCellDelegate?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20.0
        backgroundColor = .orange
        addGestureRecognizer(longPressGesture)
    }
    

    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            print("long press activated")

            delegate?.didLongPress(self)
        }
    }
    
    
    public func configureCell(imageObject: Image) {
        guard let image = UIImage(data: imageObject.imageData) else{
            return
        }
        imageView.image = image
        textLabel.text = imageObject.descript
    }
}

