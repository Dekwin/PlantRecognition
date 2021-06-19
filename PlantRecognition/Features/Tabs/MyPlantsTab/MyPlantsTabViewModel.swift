//
//  Created by Igor Kasyanenko on 19.06.2021.
//

protocol MyPlantsTabViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class MyPlantsTabViewModel {
    private let router: MyPlantsTabRouterProtocol
    weak var view: MyPlantsTabViewProtocol?
    
    init(
        router: MyPlantsTabRouterProtocol
    ) {
        self.router = router
    }
}

// MARK:  MyPlantsTabViewModelProtocol
extension MyPlantsTabViewModel: MyPlantsTabViewModelProtocol {
    func viewLoaded() {
        view?.update(
            with: .init(
                tabBarItem: .init(title: L10n.MainTabBar.Tabs.myPlants, image: Asset.Iconly.leaf.image, selectedImage: nil)
            )
        )
    }
}
