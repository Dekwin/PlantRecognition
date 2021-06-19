//
//  Created by Igor Kasyanenko on 19.06.2021.
//

protocol SearchTabViewModelProtocol: AnyObject {
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
    func viewLoaded() {
        view?.update(with: .init())
    }
}
