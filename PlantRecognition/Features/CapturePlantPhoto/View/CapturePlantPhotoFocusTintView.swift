//
//  CapturePlantPhotoFocusView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.06.2021.
//

import Foundation
import UIKit

final class CapturePlantPhotoFocusTintView: UIView {
    private let appearance = Appearance()
    private lazy var photoCenterFrameView = UIImageView(
        image: Asset.Images.CapturePhoto.centerFrame.image
    )
    
    private lazy var leftOffsetBgView = buildBgView()
    private lazy var rightOffsetBgView = buildBgView()
    private lazy var topOffsetBgView = buildBgView()
    private lazy var bottomOffsetBgView = buildBgView()
    
    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView(
            arrangedSubviews: [
                leftOffsetBgView,
                photoCenterFrameView,
                rightOffsetBgView
            ]
        )
        horizontalStackView.axis = .horizontal
        
        return horizontalStackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView(
            arrangedSubviews: [
                topOffsetBgView,
                horizontalStackView,
                bottomOffsetBgView
            ]
        )
        verticalStackView.axis = .vertical
        
        return verticalStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        
    }
}

// MARK: - Private methods
private extension CapturePlantPhotoFocusTintView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(verticalStackView)
    }
    
    func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        leftOffsetBgView.snp.makeConstraints { make in
            make.width.equalTo(appearance.photoCenterFrameViewInsets.left)
        }
        rightOffsetBgView.snp.makeConstraints { make in
            make.width.equalTo(appearance.photoCenterFrameViewInsets.right)
        }
        
        //        topOffsetBgView.snp.makeConstraints { make in
        //            make.height.equalTo(appearance.photoCenterFrameViewInsets.top)
        //        }
        
        photoCenterFrameView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(appearance.photoCenterFrameViewInsets.top)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(appearance.photoCenterFrameViewInsets.bottom)
        }
        
        //        bottomOffsetBgView.snp.makeConstraints { make in
        //            make.height.equalTo(appearance.photoCenterFrameViewInsets.bottom)
        //        }
    }
    
    func buildBgView() -> UIView {
        let view = UIView()
        view.backgroundColor = appearance.bgColor
        return view
    }
}

// MARK: - Model
extension CapturePlantPhotoFocusTintView {
    struct Model {
        
    }
}

// MARK: - Appearance
private extension CapturePlantPhotoFocusTintView {
    struct Appearance {
        let bgColor: UIColor = Asset.Colors.mainGreen.color.withAlphaComponent(0.2)
        let photoCenterFrameViewInsets: UIEdgeInsets = .init(top: .gap4XL, left: .gap4XL, bottom: .gap4XL, right: .gap4XL)
    }
}

