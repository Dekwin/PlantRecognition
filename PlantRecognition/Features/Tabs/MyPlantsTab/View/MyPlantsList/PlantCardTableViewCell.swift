//
//  PlantCardTableViewCell.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation
import UIKit


final class PlantCardTableViewCell: UITableViewCell {
    private let appearance = Appearance()
    
    private lazy var customView = PlantCardView()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupSubviews()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: PlantCardView.Model) {
        customView.update(with: model)
    }
}

private extension PlantCardTableViewCell {
    // MARK: - Helpers
    
    func setupSubviews() {
        contentView.addSubview(customView)
    }

    func setupConstraints() {
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(appearance.cellInsets)
        }
    }
}

// MARK: - Appearance
private extension PlantCardTableViewCell {
    struct Appearance {
        let cellInsets: UIEdgeInsets = .init(top: 0.0, left: 0.0, bottom: .gapM, right: 0)
    }
}
