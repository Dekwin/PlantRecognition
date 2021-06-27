//
//  CustomNavigationController.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import Foundation
import UIKit

protocol CustomNavigationControllerProtocol {
    var customNavBarConfig: CustomNavigationController.CustomNavBarConfig { get }
}

class CustomNavigationController: UINavigationController {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        if let modalNavigationController = presentedViewController as? CustomNavigationController {
            return modalNavigationController.preferredStatusBarStyle
        }
        
        return (topViewController as? CustomNavigationControllerProtocol)?
            .customNavBarConfig
            .style
            .preferredStatusBarStyle ?? .lightContent
    }
    
    // Добавляет возможность свайпа назад на экранах с кастомной кнопкой назад
    // https://stackoverflow.com/a/43433530/1178039
    private var duringPushAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        view.backgroundColor = .clear
        interactivePopGestureRecognizer?.delegate = self
        
        setupNavController()
    }
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }
}

extension CustomNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }
        
        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let customController = viewController as? CustomNavigationControllerProtocol
        
        setup(
            with: customController?.customNavBarConfig ?? .standard,
            animated: animated
        )
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated _: Bool) {
        (navigationController as? CustomNavigationController)?.duringPushAnimation = false
    }
    
    private func setup(with config: CustomNavBarConfig, animated: Bool) {
        setNavigationBarHidden(config.isNavigationBarHidden, animated: animated)
        
        switch config.style {
        case .light:
            navigationBar.tintColor = .white
        case .dark:
            navigationBar.tintColor = .black
        }
    }
}

extension CustomNavigationController {
    struct CustomNavBarConfig {
        let isNavigationBarHidden: Bool
        let style: NavBarStyle
        
        enum NavBarStyle {
            case dark
            case light
        }
        
        static let standard = CustomNavBarConfig(isNavigationBarHidden: false, style: .light)
    }
}

extension CustomNavigationController.CustomNavBarConfig.NavBarStyle {
    var preferredStatusBarStyle: UIStatusBarStyle {
        switch self {
        case .light:
            return .lightContent
        case .dark:
            return .default
        }
    }
}

private extension CustomNavigationController {
    func setupNavController() {
        let backImage = Asset.Images.Iconly.arrowLeftWhite.image
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
