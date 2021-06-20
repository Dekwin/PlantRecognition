//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol SettingsTabViewProtocol: AlertLoaderPresentable {
    func update(with model: SettingsTabViewController.Model)
}

final class SettingsTabViewController: UIViewController {
    private let viewModel: SettingsTabViewModelProtocol
    private let appearance = Appearance()
    private lazy var customView = SettingsTabView()
    
    init(viewModel: SettingsTabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem(viewModel.tabBarItem)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewLoaded()
    }
    
    private func setupTabBarItem(_ item: TabBarItem) {
        tabBarItem = .init(
            title: item.title,
            image: item.image,
            selectedImage: item.selectedImage
        )
        tabBarItem.titlePositionAdjustment = appearance.tabBarItemAppearance.titlePositionAdjustment
        tabBarItem.imageInsets = appearance.tabBarItemAppearance.imageInsets
        
        tabBarItem.setTitleTextAttributes(appearance.tabBarItemAppearance.itemTextAttributes, for: .normal)
    }
}

// MARK: - SettingsTabViewProtocol
extension SettingsTabViewController: SettingsTabViewProtocol {
    func update(with model: Model) {
        customView.update(with: .init())
    }
}

// MARK: Model
extension SettingsTabViewController {
    struct Model {
    }
    
    struct TabBarItem {
        let title: String?
        let image: UIImage?
        let selectedImage: UIImage?
    }
}

private extension SettingsTabViewController {
    struct Appearance {
        let tabBarItemAppearance: TabBarItemAppearance = .init()
    }
    
    struct TabBarItemAppearance {
        let titlePositionAdjustment: UIOffset = .init(horizontal: 0, vertical: -12)
        let imageInsets: UIEdgeInsets = .init(top: -2, left: 0, bottom: 2, right: 0)
        let itemTextAttributes: [NSAttributedString.Key : Any] = [
            .font: TextStyle.tabsText.styleAttributes.font,
        ]
    }
}


