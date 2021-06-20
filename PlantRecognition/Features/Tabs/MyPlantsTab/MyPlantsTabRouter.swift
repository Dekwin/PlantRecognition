//
//  Created by Igor Kasyanenko on 19.06.2021.
//

// sourcery: AutoMockable
protocol MyPlantsTabRouterProtocol: AnyObject {
    
}

final class MyPlantsTabRouter: MyPlantsTabRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
}
