//
//  Created by Igor Kasyanenko on 19.06.2021.
//

// sourcery: AutoMockable
protocol MainTabBarRouterProtocol: AnyObject {
    
}

final class MainTabBarRouter: MainTabBarRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
}
