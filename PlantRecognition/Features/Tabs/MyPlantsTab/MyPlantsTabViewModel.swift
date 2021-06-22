//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import Foundation

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
                body: buildBodyModel()
            )
        )
    }
    
    private func buildBodyModel() -> MyPlantsTabView.Body {
        return .noPlantsYet(
            buildNoPlantsYetModel()
        )
    }
    
    private func buildNoPlantsYetModel() -> MyPlantsTabNoPlantsYetView.Model {
        let questionCardText: NSAttributedString = .init(string: "What will be your first plant?\nSearch it now")
        return .init(
            questionCardModel: .init(
                image: Asset.Images.Tabs.MyPlants.question.image,
                title: .attributed(questionCardText)
            ),
            addPlantButtonModel: .init(
                title: L10n.MyPlantsTab.NoPlantsYet.addYourFirstPlantButton,
                action: { [weak self] in
                    self?.addPlantTouched()
                }
            )
        )
    }
    
    private func addPlantTouched() {
        
    }
}
