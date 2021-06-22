//
//  MyPlantsTabNoPlantsYetView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 22.06.2021.
//

import Foundation
import UIKit

final class MyPlantsTabNoPlantsYetView: UIView {
    private lazy var infoCardView: InfoCardView = .init()
    private lazy var addPlantButton = DefaultButton(frame: .zero)
    
    private var addPlantButtonAction: Action?
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                infoCardView,
                addPlantButton
            ]
        )
        stackView.axis = .vertical
        return stackView
    }()
    
    private let appearance = Appearance()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        infoCardView.update(with: model.questionCardModel)
        addPlantButton.update(
            with: .init(title: model.addPlantButtonModel.title, action: model.addPlantButtonModel.action)
        )
    }
    
    @objc
    private func addPlant() {
        addPlantButtonAction?()
    }
}

// MARK: - Private methods
private extension MyPlantsTabNoPlantsYetView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(contentStackView)
    }
    
    func setupConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentStackView.setCustomSpacing(appearance.questionCardAndButtonSpacing, after: infoCardView)
    }
}

// MARK: - Model
extension MyPlantsTabNoPlantsYetView {
    struct Model {
        let questionCardModel: InfoCardView.Model
        let addPlantButtonModel: AddPlantButtonModel
    }
    
    struct AddPlantButtonModel {
        let title: String
        let action: Action
    }
}

// MARK: - Appearance
private extension MyPlantsTabNoPlantsYetView {
    struct Appearance {
        let questionCardAndButtonSpacing: CGFloat = .gapXL
    }
}
