//
//  HomePageViewController.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.05.2021.
//

import UIKit
import SnapKit

protocol HomePageViewControllerProtocol: AlertPresentable {
    func update(model: HomePageView.Model)
}

class HomePageViewController: UIViewController {
    private let customView = HomePageView(frame: .zero)
    private let viewModel: HomePageViewModelProtocol
    
    init(viewModel: HomePageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        viewModel.viewLoaded()
    }
    
    private func setupSubviews() {
        view.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomePageViewController: HomePageViewControllerProtocol {
    func update(model: HomePageView.Model) {
        customView.update(model: model)
    }
}
