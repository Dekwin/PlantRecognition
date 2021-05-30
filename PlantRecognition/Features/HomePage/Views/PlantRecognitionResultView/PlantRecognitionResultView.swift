//
//  PlantRecognitionResultView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.05.2021.
//

import Foundation
import UIKit
import SnapKit

final class PlantRecognitionResultView: UIView {

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                headerLabel,
                itemsStackView
            ]
        )
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Recognition result:"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var itemsStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: []
        )
        stack.spacing = 0
        stack.axis = .vertical
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewForDescription(_ plantDescription: PlantDescription) -> UIView {
        buildTextViewForDescription(plantDescription)
    }
    
    private func buildTextViewForDescription(_ plantDescription: PlantDescription) -> UIView {
        let label = UITextView(frame: .zero)
        label.font = .systemFont(ofSize: 14)
        var descr = "Name: \"\(plantDescription.name)\""
        if let prob = plantDescription.probability {
            descr.append(", probability: \(prob.rounded(toPlaces: 3))")
        }
        label.text = descr
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.isEditable = false
        label.bounces = false
        label.isScrollEnabled = false
        return label
    }
    
    func update(model: Model) {
        switch model.recognitionResultType {
        case .one(let description):
            itemsStackView.replaceArrangedSubviews([buildViewForDescription(description)])
        case .many(let descriptions):
            let views = descriptions.map { buildViewForDescription($0) }
            itemsStackView.replaceArrangedSubviews(views)
        }
    }
    
}

extension PlantRecognitionResultView {
    struct Model {
        let recognitionResultType: RecognitionResultType
    }
    
    enum RecognitionResultType {
        case one(description: PlantDescription)
        case many(descriptions: [PlantDescription])
    }
    
    struct PlantDescription {
        let name: String
        let probability: Double?
    }
}

// MARK: - Private methods

private extension PlantRecognitionResultView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            mainStackView
        )
    }
    
    func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
