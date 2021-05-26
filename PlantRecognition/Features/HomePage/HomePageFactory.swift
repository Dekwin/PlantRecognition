//
//  HomePageFactory.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.05.2021.
//

import Foundation
import UIKit

final class HomePageFactory {
    func create() -> UIViewController {
        let transitionable = TransitionableProxy()
        
        let manager = ImagePickerManager()
        let router = HomePageRouter(transitionable: transitionable)
        let viewModel = HomePageViewModel(
            deps: .init(
                router: router,
                imagePickerManager: manager,
                plantRecognitionServiceProxy: PlantRecognitionDemoServiceProxy()
            )
        )
        let controller = HomePageViewController(viewModel: viewModel)
        
        
        manager.viewController = controller
        transitionable.wrapped = controller
        viewModel.view = controller
        
        return controller
    }
}
