//
//  AppDelegate.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.05.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFrameworks()
        
        setupWindow()
        
        return true
    }
    
    private func setupWindow() {
        /// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
        let window = UIWindow()
        
        /// 3. Create a view hierarchy programmatically
        let viewController = AppEntryPointFactory().create()
        
        /// 4. Set the root view controller of the window with view controller
        window.rootViewController = viewController
        
        /// 5. Set the window and call makeKeyAndVisible()
        self.window = window
        window.makeKeyAndVisible()
    }

    private func setupFrameworks() {
        FirebaseApp.configure()
    }

}

