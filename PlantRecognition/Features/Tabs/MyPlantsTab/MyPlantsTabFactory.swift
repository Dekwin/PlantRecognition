//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

protocol MyPlantsTabFactoryProtocol: AnyObject {
    func create() -> UIViewController
}

final class MyPlantsTabFactory: MyPlantsTabFactoryProtocol {
    func create() -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = MyPlantsTabRouter(transitionHandler: transitionHandler)
        
        let viewModel = MyPlantsTabViewModel(
            deps: .init(
                router: router,
                plantsDataService: PlantsDataServiceFactory().create(
                    isDemo: DemoHelper.shared.isDemoMode
                )
            )
        )
        
        let controller = MyPlantsTabViewController(viewModel: viewModel)
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
