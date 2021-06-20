//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol SearchTabViewProtocol: AlertLoaderPresentable {
    func update(with model: SearchTabViewController.Model)
}

final class SearchTabViewController: UIViewController {
    private let viewModel: SearchTabViewModelProtocol
    private let appearance = Appearance()
    private lazy var customView = SearchTabView()
    
    init(viewModel: SearchTabViewModelProtocol) {
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
    }
}

// MARK: - SearchTabViewProtocol
extension SearchTabViewController: SearchTabViewProtocol {
    func update(with model: Model) {
        customView.update(with: .init())
    }
}

// MARK: Model
extension SearchTabViewController {
    struct Model {
    }
    
    struct TabBarItem {
        let title: String?
        let image: UIImage?
        let selectedImage: UIImage?
    }
}

private extension SearchTabViewController {
    struct Appearance {
        let tabBarItemAppearance: TabBarItemAppearance = .init()
    }
    
    struct TabBarItemAppearance {
        let titlePositionAdjustment: UIOffset = .init(horizontal: 0, vertical: -12)
        let imageInsets: UIEdgeInsets = .init(top: -2, left: 0, bottom: 2, right: 0)
    }
}


