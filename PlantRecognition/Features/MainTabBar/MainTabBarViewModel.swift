//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

protocol MainTabBarViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class MainTabBarViewModel {
    weak var view: MainTabBarViewProtocol?
    
    private let router: MainTabBarRouterProtocol
    
    private let currentTabs: [MainTabBarTabs] = [.myPlantsTab, .searchTab, .settingsTab]
    
    init(
        router: MainTabBarRouterProtocol
    ) {
        self.router = router
    }
}

// MARK:  MainTabBarViewModelProtocol
extension MainTabBarViewModel: MainTabBarViewModelProtocol {
    func viewLoaded() {
        view?.update(with: .init())
        setupTabs()
    }
}

private extension MainTabBarViewModel {
    
    func setupTabs() {
        let tabs = currentTabs
        let tabsControllers = tabs.map { getPreparedViewController(for: $0) }
        view?.setTabs(tabsControllers, animated: false)
    }
    
    func switchToTab(_ tab: MainTabBarTabs) {
        let tabs = currentTabs
        guard
            let index = tabs.firstIndex(of: tab)
        else { return }
        
        view?.selectTab(at: index)
    }
    
    func getPreparedViewController(for tab: MainTabBarTabs) -> UIViewController {
        switch tab {
        case .myPlantsTab:
            return MyPlantsTabFactory().create()
        case .searchTab:
            return SearchTabFactory().create()
        case .settingsTab:
            return SettingsTabFactory().create()
        }
    }
}
