//
//  AppEntryPointFactory.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.05.2021.
//

import Foundation
import UIKit

final class AppEntryPointFactory {
    func create() -> UIViewController {
        let controller = MainTabBarFactory().create() //HomePageFactory().create()
        return controller
    }
}
