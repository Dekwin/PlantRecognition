//
//  DefaultButton.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 22.06.2021.
//

import Foundation
import UIKit

final class DefaultButton: UIButton {
    private let appearance = Appearance()
    
    private var buttonAction: Action?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        setAttributedTitle(
            appearance.buttonTitleStyle.createAttributedText(
                from: model.title
            ),
            for: .normal
        )
        buttonAction = model.action
    }
}

// MARK: - Private methods
private extension DefaultButton {
    func commonInit() {
        addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        setBackgroundImage(Asset.Images.Components.Buttons.defaultButtonBg.image, for: .normal)
    }
    
    @objc
    private func buttonTouched() {
        buttonAction?()
    }
}

// MARK: - Model
extension DefaultButton {
    struct Model {
        let title: String
        let action: Action
    }
}

// MARK: - Appearance
private extension DefaultButton {
    struct Appearance {
        let buttonTitleStyle: TextStyle = .subtitle16M
            .set(color: .defined(value: Asset.Colors.white.color))
            .set(alignment: .defined(value: .center))
    }
}
