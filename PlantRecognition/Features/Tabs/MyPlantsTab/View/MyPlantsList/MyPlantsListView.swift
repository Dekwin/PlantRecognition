//
//  MyPlantsListView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.06.2021.
//

import Foundation
import UIKit

final class MyPlantsListView: UIView {
    private let appearance = Appearance()
    private var refreshAction: ((_ endRefreshingAction: @escaping Action) -> Void)?
    private var plantItems: [PlantCardView.Model] = []
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshPlants), for: .valueChanged)
        return control
    }()
    private lazy var plantsTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        plantItems = model.plantItems
        refreshAction = model.refreshAction
        plantsTableView.reloadData()
    }
    
    @objc
    private func refreshPlants() {
        refreshAction? { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}

// MARK: - Private methods
private extension MyPlantsListView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(plantsTableView)
        
        plantsTableView.refreshControl = refreshControl
        
        plantsTableView.backgroundColor = .clear
        plantsTableView.tableFooterView = UIView()
        plantsTableView.separatorStyle = .none
        
        plantsTableView.estimatedRowHeight = 100.0
        plantsTableView.rowHeight = UITableView.automaticDimension
        
        plantsTableView.registerCellIdentifier(for: PlantCardTableViewCell.self)
        
        plantsTableView.delegate = self
        plantsTableView.dataSource = self
    }
    
    func setupConstraints() {
        plantsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MyPlantsListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlantCardTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let model = plantItems[indexPath.item]
        cell.update(with: model)
        
        return cell
    }
}

// MARK: - Model
extension MyPlantsListView {
    struct Model {
        let refreshAction: (_ endRefreshingAction: @escaping Action) -> Void
        let plantItems: [PlantCardView.Model]
    }
}

// MARK: - Appearance
private extension MyPlantsListView {
    struct Appearance {
        
    }
}

