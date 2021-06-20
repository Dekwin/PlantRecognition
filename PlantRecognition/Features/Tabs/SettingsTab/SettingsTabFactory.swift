//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

protocol SettingsTabFactoryProtocol: AnyObject {
    func create() -> UIViewController
}

final class SettingsTabFactory: SettingsTabFactoryProtocol {
    func create() -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = SettingsTabRouter(transitionHandler: transitionHandler)
        
        let viewModel = SettingsTabViewModel(
            router: router
        )
        
        let controller = SettingsTabViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
