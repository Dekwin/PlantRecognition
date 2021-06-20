//
//  UIViewController+AlertPresentable.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation
import UIKit

extension UIViewController: AlertPresentable {
    func presentAlert(title: String?, message: String?, completion: @escaping () -> Void) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(title: "Ok", style: .default, handler: nil)
        )
        
        self.present(alert, animated: true, completion: completion)
    }
    
    func presentAlert(error: Error) {
        presentAlert(error: error, completion: {})
    }
    
    func presentAlert(error: Error, completion: @escaping () -> Void) {
        presentAlert(
            title: "Error",
            message: error.localizedDescription,
            completion: completion
        )
    }
}
