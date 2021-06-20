//
//  Created by Igor Kasyanenko on 19.06.2021.
//

protocol SettingsTabViewModelProtocol: AnyObject {
    var tabBarItem: SettingsTabViewController.TabBarItem { get }
    func viewLoaded()
}

final class SettingsTabViewModel {
    private let router: SettingsTabRouterProtocol
    weak var view: SettingsTabViewProtocol?
    
    init(
        router: SettingsTabRouterProtocol
    ) {
        self.router = router
    }
}

// MARK:  SettingsTabViewModelProtocol
extension SettingsTabViewModel: SettingsTabViewModelProtocol {
    var tabBarItem: SettingsTabViewController.TabBarItem {
        .init(
            title: L10n.MainTabBar.Tabs.settings,
            image: Asset.Images.Iconly.notSelectedSetting.image,
            selectedImage: Asset.Images.Iconly.selectedSetting.image
        )
    }
    
    func viewLoaded() {
        view?.update(with: .init())
    }
}
