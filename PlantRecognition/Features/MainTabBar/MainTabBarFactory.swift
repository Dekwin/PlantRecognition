//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

protocol MainTabBarFactoryProtocol: AnyObject {
    func create() -> UIViewController
}

final class MainTabBarFactory: MainTabBarFactoryProtocol {
    func create() -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = MainTabBarRouter(transitionHandler: transitionHandler)
        
        let viewModel = MainTabBarViewModel(
            router: router
        )
        
        let controller = MainTabBarViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
