//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import UIKit

// sourcery: AutoMockable
protocol CapturePlantPhotoViewProtocol: AlertLoaderPresentable {
    func update(with model: CapturePlantPhotoViewController.Model)
}

final class CapturePlantPhotoViewController: UIViewController {
    private let viewModel: CapturePlantPhotoViewModelProtocol
    private lazy var customView = CapturePlantPhotoView()
    
    init(viewModel: CapturePlantPhotoViewModelProtocol) {
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
        setupNavigation()
        viewModel.viewLoaded()
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItems = [
            .init(
                image: Asset.Images.Iconly.infoSquare.image,
                style: .plain,
                target: nil,
                action: nil
            )
        ]
    }
}

// MARK: - CapturePlantPhotoViewProtocol
extension CapturePlantPhotoViewController: CapturePlantPhotoViewProtocol {
    func update(with model: Model) {
        customView.update(with: model.contentModel)
    }
}

// MARK: Model
extension CapturePlantPhotoViewController {
    struct Model {
        let contentModel: CapturePlantPhotoView.Model
    }
}
