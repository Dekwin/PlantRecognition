//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

protocol SearchTabFactoryProtocol: AnyObject {
    func create() -> UIViewController
}

final class SearchTabFactory: SearchTabFactoryProtocol {
    func create() -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = SearchTabRouter(transitionHandler: transitionHandler)
        
        let viewModel = SearchTabViewModel(
            router: router
        )
        
        let controller = SearchTabViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
