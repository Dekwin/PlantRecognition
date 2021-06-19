//
//  Created by Igor Kasyanenko on 19.06.2021.
//

protocol SettingsTabViewModelProtocol: AnyObject {
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
    func viewLoaded() {
        view?.update(with: .init())
    }
}
