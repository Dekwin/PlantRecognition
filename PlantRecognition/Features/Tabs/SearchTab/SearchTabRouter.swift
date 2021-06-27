//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol SearchTabRouterProtocol: AnyObject {
    func openCapturePlantModule()
}

final class SearchTabRouter: SearchTabRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
    
    func openCapturePlantModule() {
        let controller = CapturePlantPhotoFactory().create()
        controller.modalPresentationStyle = .fullScreen
        transitionHandler.present(controller: controller, animated: true)
    }
}
