//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import Foundation
import UIKit

protocol MyPlantsTabViewModelProtocol: AnyObject {
    var tabBarItem: MyPlantsTabViewController.TabBarItem { get }
    func viewLoaded()
}

final class MyPlantsTabViewModel {
    weak var view: MyPlantsTabViewProtocol?
    
    private let deps: Deps
    private var myPlants: [PlantDetailsInfo] = []
    
    init(
        deps: Deps
    ) {
        self.deps = deps
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
        reloadMyPlants()
    }
    
    private func updateView() {
        view?.update(
            with: .init(
                header: buildHeaderModel(),
                body: buildBodyModel(from: myPlants)
            )
        )
    }
    
    private func buildHeaderModel() -> MyPlantsTabView.Header {
        .init(
            title: L10n.MyPlantsTab.title,
            addPlantButtonAction: { [weak self] in
                self?.addPlantTouched()
            }
        )
    }
    
    private func buildBodyModel(from plants: [PlantDetailsInfo]) -> MyPlantsTabView.Body {
        if plants.isEmpty {
            return .noPlantsYet(
                buildNoPlantsYetModel()
            )
        } else {
            return .plants(
                buildMyPlantsModel(from: plants)
            )
        }
    }
  
    private func addPlantTouched() {
        print("add plant")
    }
    
    private func openPlantDetails(_ plantInfo: PlantDetailsInfo) {
        print("open plant \(plantInfo)")
    }
}

extension MyPlantsTabViewModel {
    struct Deps {
        let router: MyPlantsTabRouterProtocol
        let plantsDataService: PlantsDataServiceProtocol
    }
}

// MARK: - Plants exists logic

private extension MyPlantsTabViewModel {
    func reloadMyPlants(reloadCompletedAction: @escaping Action = {}) {
        view?.setLoading(true)
        deps.plantsDataService.getAllMyPlants { [weak self] result in
            self?.view?.setLoading(false)
            self?.handleMyPlantsLoaded(result: result)
            reloadCompletedAction()
        }
    }
    
    func handleMyPlantsLoaded(result: Result<[PlantDetailsInfo], Error>) {
        switch result {
        case.success(let plants):
            myPlants = plants
            updateView()
        case .failure(let error):
            view?.presentAlert(error: error)
        }
    }
    
    func buildMyPlantsModel(from plants: [PlantDetailsInfo]) -> MyPlantsListView.Model {
        let plantModels: [PlantCardView.Model] = plants.map { plantInfo in
            return .init(
                image: plantInfo.image,
                title: plantInfo.name,
                notificationImages: plantInfo.notifications.map { $0.type.image },
                tapAction: { [weak self] in
                    self?.openPlantDetails(plantInfo)
                }
            )
        }
        
        return .init(
            refreshAction: { [weak self] endRefreshingAction in
                self?.reloadMyPlants(
                    reloadCompletedAction: {
                        endRefreshingAction()
                    }
                )
            },
            plantItems: plantModels
        )
    }
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
