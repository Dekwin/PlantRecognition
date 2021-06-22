//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

final class MyPlantsTabView: UIView {
    private let appearance = Appearance()
    
    private lazy var titleLabel: UILabel = .init()
    private lazy var addPlantButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Images.Components.Buttons.addPlant.image, for: .normal)
        button.addTarget(self, action: #selector(addPlant), for: .touchUpInside)
        return button
    }()
    
    private var addPlantButtonAction: Action?
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                UIView(),
                addPlantButton
            ]
        )
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                
            ]
        )
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                headerStackView,
                bodyStackView,
                UIView()
            ]
        )
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        update(header: model.header)
        update(body: model.body)
    }
    
    private func update(body: Body) {
        switch body {
        case .noPlantsYet(let model):
            let view = MyPlantsTabNoPlantsYetView(frame: .zero)
            view.update(with: model)
            bodyStackView.replaceArrangedSubviews([view])
        case .plants:
            break
        }
    }
    
    private func update(header: Header) {
        titleLabel.set(text: header.title, with: appearance.headerTitleStyle)
        addPlantButtonAction = header.addPlantButtonAction
    }
    
    @objc
    private func addPlant() {
        addPlantButtonAction?()
    }
}

// MARK: - Private methods
private extension MyPlantsTabView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            contentStackView
        )
    }
    
    func setupConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(appearance.contentInsets)
        }
        contentStackView.setCustomSpacing(appearance.headerBottomInset, after: headerStackView)
    }
}

// MARK: - Model
extension MyPlantsTabView {
    struct Model {
        let header: Header
        let body: Body
    }
    
    enum Body {
        case noPlantsYet(MyPlantsTabNoPlantsYetView.Model)
        case plants(PlantsModel)
    }

    struct PlantsModel {
        
    }
    
    struct Header {
        let title: String
        let addPlantButtonAction: Action
    }
}

// MARK: - Appearance
private extension MyPlantsTabView {
    struct Appearance {
        let headerTitleStyle: TextStyle = .title32SB
        let contentInsets: UIEdgeInsets = .init(top: .gapXL, left: .gapXL, bottom: .gapXL, right: .gapXL)
        let headerBottomInset: CGFloat = .gapXL
    }
}

