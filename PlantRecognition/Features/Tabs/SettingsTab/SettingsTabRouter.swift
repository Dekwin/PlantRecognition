//
//  Created by Igor Kasyanenko on 19.06.2021.
//

// sourcery: AutoMockable
protocol SettingsTabRouterProtocol: AnyObject {
    
}

final class SettingsTabRouter: SettingsTabRouterProtocol {
    private let transitionHandler: Transitionable
    
    init(transitionHandler: Transitionable) {
        self.transitionHandler = transitionHandler
    }
}
