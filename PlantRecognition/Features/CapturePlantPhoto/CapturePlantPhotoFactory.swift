//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import UIKit

protocol CapturePlantPhotoFactoryProtocol: AnyObject {
    func create() -> UIViewController
}

final class CapturePlantPhotoFactory: CapturePlantPhotoFactoryProtocol {
    func create() -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = CapturePlantPhotoRouter(transitionHandler: transitionHandler)
        
        let viewModel = CapturePlantPhotoViewModel(
            router: router
        )
        
        let controller = CapturePlantPhotoViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
