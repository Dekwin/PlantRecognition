//
//  Created by Igor Kasyanenko on 27.06.2021.
//

// sourcery: AutoMockable
protocol CapturePlantPhotoRouterProtocol: AnyObject {
    
}

final class CapturePlantPhotoRouter: CapturePlantPhotoRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
}
