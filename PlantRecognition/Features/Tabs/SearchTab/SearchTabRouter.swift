//
//  Created by Igor Kasyanenko on 19.06.2021.
//

// sourcery: AutoMockable
protocol SearchTabRouterProtocol: AnyObject {
    
}

final class SearchTabRouter: SearchTabRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
}
