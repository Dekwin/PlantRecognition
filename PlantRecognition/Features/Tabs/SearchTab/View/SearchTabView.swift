//
//  Created by Igor Kasyanenko on 19.06.2021.
//

import UIKit

final class SearchTabView: UIView {
    private let appearance = Appearance()
    private var takePhotoAction: Action?
    private lazy var titleLabel: UILabel = .init()
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                UIView()
            ]
        )
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var centerImageView: UIImageView = .init(
        image: appearance.centerImage
    )
    
    private lazy var bgGradientView: SearchTabBgGradientView = .init()
    
    private lazy var takePhotoButton: UIButton = {
        let takePhotoButton = UIButton()
        takePhotoButton.setImage(appearance.takePhotoImage, for: .normal)
        return takePhotoButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        titleLabel.set(text: model.headerTitle, with: appearance.headerTitleStyle)
        takePhotoAction = model.takePhotoAction
    }
}

// MARK: - Private methods
private extension SearchTabView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            bgGradientView,
            centerImageView,
            headerStackView,
            takePhotoButton
        )
        centerImageView.contentMode = .scaleAspectFit
        takePhotoButton.addTarget(self, action: #selector(takePhotoTouched), for: .touchUpInside)
    }
    
    func setupConstraints() {
        headerStackView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(safeAreaLayoutGuide).inset(appearance.contentInsets)
        }
        centerImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(appearance.contentInsets)
            make.top.equalTo(headerStackView.snp.bottom).inset(-appearance.headerBottomInset)
            make.bottom.equalTo(takePhotoButton.snp.top).inset(-appearance.centerImageBottomInset)
        }
        bgGradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        takePhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(bgGradientView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(appearance.takePhotoBottomInset)
        }
    }
    
    @objc
    private func takePhotoTouched() {
        takePhotoAction?()
    }
}

// MARK: - Model
extension SearchTabView {
    struct Model {
        let headerTitle: String
        let takePhotoAction: Action
    }
}

// MARK: - Appearance
private extension SearchTabView {
    struct Appearance {
        let headerTitleStyle: TextStyle = .title32SB
        let contentInsets: UIEdgeInsets = .init(top: .gapXL, left: .gapXL, bottom: .gapXL, right: .gapXL)
        let centerImage: UIImage = Asset.Images.Tabs.Search.manWithPlant.image
        let headerBottomInset: CGFloat = .gap6XL
        let centerImageBottomInset: CGFloat = .gap6XL
        let takePhotoImage: UIImage = Asset.Images.Components.Buttons.takePhoto.image
        let takePhotoBottomInset: CGFloat = .gap4XL
    }
}

