//
//  UIView+LoaderPresentable.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.05.2021.
//

import Foundation
import UIKit
import MBProgressHUD

extension LoaderPresentable {
    func showAndHideLoader(after seconds: TimeInterval) {
        self.setLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            self?.setLoading(false)
        }
    }
}
extension UIViewController: LoaderPresentable {
    func setLoading(_ present: Bool) {
        if present {
            MBProgressHUD.showAdded(to: view, animated: true)
        } else {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}

extension UIView: LoaderPresentable {
    func setLoading(_ present: Bool) {
        if present {
            MBProgressHUD.showAdded(to: self, animated: true)
        } else {
            MBProgressHUD.hide(for: self, animated: true)
        }
    }
}

