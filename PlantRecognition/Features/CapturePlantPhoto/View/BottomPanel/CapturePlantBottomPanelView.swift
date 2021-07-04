//
//  CapturePlantBottomPanelView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 30.06.2021.
//

import Foundation
import UIKit

final class CapturePlantBottomPanelView: UIView {
    private let appearance = Appearance()
    private let circleShapeLayer: CAShapeLayer = CAShapeLayer()
    private lazy var takePhotoButton: UIButton = .init()
    private lazy var selectImageFromGalleryView = SelectImageFromGalleryView()
    private lazy var photoAttemptsVipView = PhotoAttemptsVipView()
    
    private var takePhotoButtonAction: Action?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        takePhotoButtonAction = model.takePhotoButtonAction
        
        if let model = model.selectImageFromGalleryModel {
            selectImageFromGalleryView.update(with: model)
            selectImageFromGalleryView.isHidden = false
        } else {
            selectImageFromGalleryView.isHidden = true
        }
        
        if let model = model.photoAttemptsVipModel {
            photoAttemptsVipView.update(with: model)
            photoAttemptsVipView.isHidden = false
        } else {
            photoAttemptsVipView.isHidden = true
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        circleShapeLayer.frame = bounds
        setupDrawing()
    }
}

// MARK: - Private methods
private extension CapturePlantBottomPanelView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        clipsToBounds = true
        layer.addSublayer(circleShapeLayer)
        addSubviews(
            selectImageFromGalleryView,
            takePhotoButton,
            photoAttemptsVipView
        )
        
        takePhotoButton.setImage(Asset.Images.CapturePhoto.takePhoto.image, for: .normal)
        takePhotoButton.addTarget(self, action: #selector(takePhotoTouched), for: .touchUpInside)
        
        selectImageFromGalleryView.isHidden = true
        photoAttemptsVipView.isHidden = true
    }
    
    func setupConstraints() {
        takePhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
       
        
        let leftLayoutGuide = UILayoutGuide()
        addLayoutGuide(leftLayoutGuide)
        
        let rightLayoutGuide = UILayoutGuide()
        addLayoutGuide(rightLayoutGuide)
        
        leftLayoutGuide.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(takePhotoButton.snp.left)
        }
        
        rightLayoutGuide.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalTo(takePhotoButton.snp.right)
        }
        
        selectImageFromGalleryView.snp.makeConstraints { make in
            make.size.equalTo(appearance.selectImageFromGalleryViewSize)
            make.center.equalTo(leftLayoutGuide.snp.center)
        }
        
        photoAttemptsVipView.snp.makeConstraints { make in
            make.center.equalTo(rightLayoutGuide.snp.center)
        }
    }
    
    @objc
    func takePhotoTouched() {
        takePhotoButtonAction?()
    }
}

// MARK: - Model
extension CapturePlantBottomPanelView {
    struct Model {
        let takePhotoButtonAction: Action
        let selectImageFromGalleryModel: SelectImageFromGalleryView.Model?
        let photoAttemptsVipModel: PhotoAttemptsVipView.Model?
    }
}

// MARK: - Appearance
private extension CapturePlantBottomPanelView {
    struct Appearance {
        let selectImageFromGalleryViewSize: CGSize = .init(width: 48, height: 48)
    }
}

// MARK: - Drawing
private extension CapturePlantBottomPanelView {
    func setupDrawing() {
        circleShapeLayer.fillColor = UIColor.white.cgColor
        circleShapeLayer.path = createBezierPath().cgPath
    }
    
    func createBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        let size = layer.bounds.size
        
        path.move(to: .init(x: 0, y: 0))
        path.addLine(to: .init(x: 0, y: size.height))
        path.addLine(to: .init(x: size.width, y: size.height))
        path.addLine(to: .init(x: size.width, y: 0))
        
        let radiusWidthMultiplier: CGFloat = 2
        
        let radius = radiusWidthMultiplier * size.width
        let x = layer.bounds.midX
        let y = radius
        path.addArc(withCenter: .init(x: x, y: y), radius: radius, startAngle: 0, endAngle: -.pi, clockwise: false)
        
        return path
    }
}
