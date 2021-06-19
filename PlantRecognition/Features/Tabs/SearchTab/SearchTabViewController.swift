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
    private lazy var customView = SearchTabView()
    
    init(viewModel: SearchTabViewModelProtocol) {
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
}
