//
//  Created by Igor Kasyanenko on 19.06.2021.
//

protocol SearchTabViewModelProtocol: AnyObject {
    var tabBarItem: SearchTabViewController.TabBarItem { get }
    func viewLoaded()
}

final class SearchTabViewModel {
    private let router: SearchTabRouterProtocol
    weak var view: SearchTabViewProtocol?
    
    init(
        router: SearchTabRouterProtocol
    ) {
        self.router = router
    }
}

// MARK:  SearchTabViewModelProtocol
extension SearchTabViewModel: SearchTabViewModelProtocol {
    var tabBarItem: SearchTabViewController.TabBarItem {
        .init(
            title: L10n.MainTabBar.Tabs.search,
            image: Asset.Iconly.notSelectedSearch.image,
            selectedImage: Asset.Iconly.selectedSearch.image
        )
    }
    
    func viewLoaded() {
        view?.update(with: .init())
    }
}
