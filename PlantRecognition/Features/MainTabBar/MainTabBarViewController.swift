//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol MainTabBarViewProtocol: AlertLoaderPresentable {
    func update(with model: MainTabBarViewController.Model)
}

final class MainTabBarViewController: UITabBarController {
    private let viewModel: MainTabBarViewModelProtocol
    
    init(viewModel: MainTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewLoaded()
    }
}

// MARK: - MainTabBarViewProtocol
extension MainTabBarViewController: MainTabBarViewProtocol {
    func update(with model: Model) {
        
    }
}

// MARK: Model
extension MainTabBarViewController {
    struct Model {
        
    }
}
