//
//  AlertPresentable.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.05.2021.
//

import Foundation

protocol AlertPresentable: AnyObject {
    func presentAlert(title: String?, message: String?, completion: @escaping () -> Void)
    func presentAlert(error: Error)
    func presentAlert(error: Error, completion: @escaping () -> Void)
}
