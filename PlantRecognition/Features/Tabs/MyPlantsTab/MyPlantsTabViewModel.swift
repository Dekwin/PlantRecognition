//
//  Created by Igor Kasyanenko on 19.06.2021.
//

protocol MyPlantsTabViewModelProtocol: AnyObject {
    var tabBarItem: MyPlantsTabViewController.TabBarItem { get }
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
    var tabBarItem: MyPlantsTabViewController.TabBarItem {
        .init(
            title: L10n.MainTabBar.Tabs.myPlants,
            image: Asset.Images.Iconly.notSelectedLeaf.image,
            selectedImage: Asset.Images.Iconly.selectedLeaf.image
        )
    }
    
    func viewLoaded() {
        updateView()
    }
    
    private func updateView() {
        view?.update(
            with: .init(
                header: .init(
                    title: L10n.MyPlantsTab.title,
                    addPlantButtonAction: { [weak self] in
                        self?.addPlantTouched()
                    }
                ),
                body: .noPlantsYet(.init())
            )
        )
    }
    
    private func addPlantTouched() {
        
    }
}
