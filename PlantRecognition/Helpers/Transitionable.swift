//
//  Transitionable.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.05.2021.
//

import Foundation
import UIKit

protocol Transitionable: AnyObject {
    func present(controller: UIViewController, animated: Bool)
    func present(controller: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    func push(controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

final class TransitionableProxy {
    weak var wrapped: UIViewController?
}

extension TransitionableProxy: Transitionable {

    func present(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        wrapped?.present(controller, animated: animated, completion: completion)
    }
    
    func present(controller: UIViewController, animated: Bool) {
        present(controller: controller, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        wrapped?.dismiss(animated: animated, completion: completion)
    }
    
    func push(controller: UIViewController, animated: Bool) {
        let navController = (wrapped as? UINavigationController) ?? wrapped?.navigationController
        
        navController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        let navController = (wrapped as? UINavigationController) ?? wrapped?.navigationController
        
        navController?.popViewController(animated: animated)
    }
}
