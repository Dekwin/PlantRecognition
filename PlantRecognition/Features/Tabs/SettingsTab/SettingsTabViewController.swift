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
    private lazy var customView = SettingsTabView()
    
    init(viewModel: SettingsTabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
}
