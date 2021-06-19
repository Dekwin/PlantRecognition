//
//  Created by Igor Kasyanenko on 19.06.2021.
//

protocol MainTabBarViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class MainTabBarViewModel {
    private let router: MainTabBarRouterProtocol
    weak var view: MainTabBarViewProtocol?
    
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
    }
}
