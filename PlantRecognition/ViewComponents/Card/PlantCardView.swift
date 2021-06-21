//
//  PlantCardView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 21.06.2021.
//

import Foundation
import UIKit

final class PlantCardView: UIView {
    private let appearance = Appearance()
    private lazy var settingButton: UIButton = .init(type: .custom)
    private lazy var bgImageView: UIImageView = .init(image: Asset.Images.Components.Cards.cardBg.image)
    private lazy var leftImageView: UIImageView = .init(image: nil)
    private lazy var titleLabel: UILabel = .init()
    private lazy var notificationsStackView: UIStackView = {
        let notificationsStackView = UIStackView(arrangedSubviews: [])
        notificationsStackView.axis = .horizontal
        notificationsStackView.spacing = appearance.notificationsSpacing
        return notificationsStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        leftImageView.image = model.image
        titleLabel.set(text: model.title, with: appearance.titleStyle)
        
        setupNotifications(model.notificationImages)
    }
    
    private func setupNotifications(_ notificationImages: [UIImage]) {
        let imageViews: [UIImageView] = notificationImages.map { image in
            let view = UIImageView(image: image)
            view.snp.makeConstraints { make in
                make.size.equalTo(appearance.notificationSize)
            }
            return view
        }
        notificationsStackView.replaceArrangedSubviews(imageViews)
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).inset(-appearance.titleImageSpacing)
            make.trailing.equalTo(settingButton.snp.leading).inset(-appearance.settingsTitleSpacing)
            let notificationsNotExist = imageViews.isEmpty
            if notificationsNotExist {
                make.centerY.equalToSuperview()
            } else {
                make.bottom.equalTo(notificationsStackView.snp.top).inset(-appearance.titleNotificationsSpacing)
            }
        }
    }
}

// MARK: - Private methods
private extension PlantCardView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            bgImageView,
            leftImageView,
            titleLabel,
            settingButton,
            notificationsStackView
        )
        
        settingButton.setImage(Asset.Images.Iconly.more.image, for: .normal)
        settingButton.imageView?.contentMode = .center
        
        layer.cornerRadius = appearance.radius
        layer.masksToBounds = true
        
        leftImageView.layer.cornerRadius = appearance.radius
        leftImageView.layer.masksToBounds = true
        
        leftImageView.contentMode = .scaleAspectFill
    }
    
    func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.size.equalTo(appearance.imageSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).inset(-appearance.titleImageSpacing)
            make.trailing.equalTo(settingButton.snp.leading).inset(-appearance.settingsTitleSpacing)
            make.centerY.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(appearance.settingsTrailingInset)
            make.centerY.equalToSuperview()
            make.size.equalTo(appearance.settingsButtonSize)
        }
        
        notificationsStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(appearance.notificationsBottomInset)
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }
}

// MARK: - Model
extension PlantCardView {
    struct Model {
        let image: UIImage
        let title: String
        let notificationImages: [UIImage]
    }
}

// MARK: - Appearance
private extension PlantCardView {
    struct Appearance {
        let imageSize: CGSize = .init(width: 100.0, height: 100.0)
        let titleImageSpacing: CGFloat = .gapL
        /// if any notifications exists
        let titleNotificationsSpacing: CGFloat = .gapXL
        let settingsTrailingInset: CGFloat = .gapS
        let notificationsBottomInset: CGFloat = .gapS
        let notificationsSpacing: CGFloat = .gapXS
        let settingsTitleSpacing: CGFloat = .gapS
        let notificationSize: CGSize = .init(width: 18.0, height: 18.0)
        let titleStyle: TextStyle = .subtitle18M
        let settingsButtonSize: CGSize = .init(width: 24, height: 24)
        let radius: CGFloat = 20
    }
}
