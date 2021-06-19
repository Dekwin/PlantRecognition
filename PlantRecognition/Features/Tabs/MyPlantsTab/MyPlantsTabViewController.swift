//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol MyPlantsTabViewProtocol: AlertLoaderPresentable {
    func update(with model: MyPlantsTabViewController.Model)
}

final class MyPlantsTabViewController: UIViewController {
    private let viewModel: MyPlantsTabViewModelProtocol
    private lazy var customView = MyPlantsTabView()
    
    init(viewModel: MyPlantsTabViewModelProtocol) {
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

// MARK: - MyPlantsTabViewProtocol
extension MyPlantsTabViewController: MyPlantsTabViewProtocol {
    func update(with model: Model) {
        customView.update(with: .init())
    }
}

// MARK: Model
extension MyPlantsTabViewController {
    struct Model {
        
    }
}
