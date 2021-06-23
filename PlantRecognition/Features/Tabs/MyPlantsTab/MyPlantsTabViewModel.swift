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
  
    private func addPlantTouched() {
        print("add plant")
    }
}

// MARK: - Plants exists logic

private extension MyPlantsTabViewModel {
    
}

// MARK: - No plants logic

private extension MyPlantsTabViewModel {
    
    func buildNoPlantsYetModel() -> MyPlantsTabNoPlantsYetView.Model {
        let questionCardText = buildQuestionCardText()
        return .init(
            questionCardModel: .init(
                image: Asset.Images.Tabs.MyPlants.question.image,
                title: .attributed(questionCardText),
                tapAction: { [weak self] in
                    self?.addPlantTouched()
                }
            ),
            addPlantButtonModel: .init(
                title: L10n.MyPlantsTab.NoPlantsYet.addYourFirstPlantButton,
                action: { [weak self] in
                    self?.addPlantTouched()
                }
            )
        )
    }
    
    func buildQuestionCardText() -> NSAttributedString {
        let questionCardText = NSMutableAttributedString()
        let style1 = TextStyle.subtitle18M.set(color: .defined(value: Asset.Colors.black.color))
        let style2 = TextStyle.subtitle18M.set(color: .defined(value: Asset.Colors.additionalGreen.color))
        
        questionCardText.append(style1.createAttributedText(from: L10n.MyPlantsTab.NoPlantsYet.QuestionCard.Title.part1))
        questionCardText.append(style1.createAttributedText(from: " "))
        questionCardText.append(style2.createAttributedText(from: L10n.MyPlantsTab.NoPlantsYet.QuestionCard.Title.part2))
        
        return questionCardText
    }
    
}
