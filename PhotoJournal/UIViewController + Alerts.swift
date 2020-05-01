//
//  UIViewController + Alerts.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 5/1/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlert(title: String?, message: String?, _ completion: ((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
