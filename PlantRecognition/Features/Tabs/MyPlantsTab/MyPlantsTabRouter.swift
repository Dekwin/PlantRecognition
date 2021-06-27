//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol MyPlantsTabRouterProtocol: AnyObject {
    func openCapturePlantModule()
}

final class MyPlantsTabRouter: MyPlantsTabRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
    
    func openCapturePlantModule() {
        let controller = CapturePlantPhotoFactory().create()
        controller.modalPresentationStyle = .fullScreen
        
        transitionHandler.push(controller: controller, animated: true)
    }
}
