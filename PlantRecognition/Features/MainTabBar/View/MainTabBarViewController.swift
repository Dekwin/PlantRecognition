//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol MainTabBarViewProtocol: AlertLoaderPresentable {
    func update(with model: MainTabBarViewController.Model)
    
    func setTabs(_ viewControllers: [UIViewController], animated: Bool)
    func selectTab(at index: Int)
}

final class MainTabBarViewController: UITabBarController {
    private let viewModel: MainTabBarViewModelProtocol
    private var isViewAppearedEarlier: Bool = false
    
    private lazy var customTabBar: UITabBar = {
        let tabBar = MainTabBarTabView(frame: .zero)
        return tabBar
    }()
    
    init(viewModel: MainTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Workaround: viewDidLoad called during initializer execution
        if isViewAppearedEarlier == false {
            viewModel.viewLoaded()
        }
        isViewAppearedEarlier = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
        setupSubviews()
    }
    
    private func setupSubviews() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil
        )
        if #available(iOS 14.0, *) {
            navigationItem.backButtonTitle = ""
        }
    }
}

extension MainTabBarViewController: CustomNavigationControllerProtocol {
    var customNavBarConfig: CustomNavigationController.CustomNavBarConfig {
        .init(isNavigationBarHidden: true, style: .light)
    }
}

// MARK: - MainTabBarViewProtocol
extension MainTabBarViewController: MainTabBarViewProtocol {
    func update(with model: Model) {
        
    }
    
    func setTabs(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllers(viewControllers, animated: animated)
    }
    
    func selectTab(at index: Int) {
        selectedIndex = index
    }
}

// MARK: Model
extension MainTabBarViewController {
    struct Model {
        
    }
}
