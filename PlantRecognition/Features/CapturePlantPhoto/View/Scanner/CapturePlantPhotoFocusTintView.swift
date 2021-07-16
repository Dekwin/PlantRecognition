//
//  CapturePlantPhotoFocusView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 29.06.2021.
//

import Foundation
import UIKit
import AVFoundation

final class CapturePlantPhotoFocusTintView: UIView {
    private let appearance = Appearance()
    private lazy var photoCenterFrameView = UIImageView(
        image: Asset.Images.CapturePhoto.centerFrame.image
    )
    private lazy var photoCenterFrameScannerView = CapturePlantPhotoScanningView()
    private lazy var bgView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var leftOffsetBgView = buildBgView()
    private lazy var rightOffsetBgView = buildBgView()
    private lazy var topOffsetBgView = buildBgView()
    private lazy var bottomOffsetBgView = buildBgView()
    
    private lazy var tipView = TipView()
    
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
        if let tip = model.tip {
            tipView.update(with: tip)
            tipView.isHidden = false
        } else {
            tipView.isHidden = true
        }
        
        switch model.state {
        case .readyToTakePhoto(let model):
            photoCenterFrameScannerView.update(with: .init(state: .stopScanning))
            photoCenterFrameScannerView.isHidden = true
            setupBgView(with: model.videoPreviewLayer)
        case .scanning(let model):
            photoCenterFrameScannerView.update(with: .init(state: .startScanning))
            photoCenterFrameScannerView.isHidden = false
            setupBgView(with: model.image)
        }
    }
    
    private func setupBgView(with videoPreviewLayer: AVCaptureVideoPreviewLayer) {
        let previewView = UIView()
        previewView.layer.addSublayer(videoPreviewLayer)
        
        bgView.removeAllSubviews()
        
        bgView.addSubview(previewView)
        previewView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        previewView.layoutIfNeeded()
        videoPreviewLayer.frame = previewView.bounds
    }
    
    private func setupBgView(with image: UIImage) {
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        
        bgView.removeAllSubviews()
        
        bgView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Private methods
private extension CapturePlantPhotoFocusTintView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            bgView,
            photoCenterFrameScannerView,
            verticalStackView,
            tipView
        )
        photoCenterFrameScannerView.isHidden = true
    }
    
    func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        
//        photoCenterFrameView.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).inset(appearance.photoCenterFrameViewInsets.top)
//            make.bottom.equalTo(safeAreaLayoutGuide).inset(appearance.photoCenterFrameViewInsets.bottom)
//        }
        
        //        bottomOffsetBgView.snp.makeConstraints { make in
        //            make.height.equalTo(appearance.photoCenterFrameViewInsets.bottom)
        //        }
        
        bottomOffsetBgView.snp.makeConstraints { make in
            make.height.equalTo(topOffsetBgView.snp.height)
        }
        
        
        photoCenterFrameView.snp.makeConstraints { make in
            make.width.equalTo(photoCenterFrameView.snp.height).multipliedBy(appearance.photoCenterFrameAspectRatio)
        }
        
        photoCenterFrameScannerView.snp.makeConstraints { make in
            make.edges.equalTo(photoCenterFrameView)
        }
        
    
        tipView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(appearance.tipViewTopOffset).priority(.high)
            make.bottom.lessThanOrEqualTo(photoCenterFrameView.snp.top).inset(-appearance.tipViewMinBottomTopOffset)
            make.centerX.equalToSuperview()
        }
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
        let tip: TipView.Model?
        let state: State
    }
    
    enum State {
        case readyToTakePhoto(ReadyToTakePhotoModel)
        case scanning(ScanningModel)
    }
    
    struct ScanningModel {
        let image: UIImage
    }
    
    struct ReadyToTakePhotoModel {
        let videoPreviewLayer: AVCaptureVideoPreviewLayer
    }
}

// MARK: - Appearance
private extension CapturePlantPhotoFocusTintView {
    struct Appearance {
        let bgColor: UIColor = Asset.Colors.mainGreen.color.withAlphaComponent(0.2)
        let photoCenterFrameViewInsets: UIEdgeInsets = .init(top: 80, left: .gap4XL, bottom: .gap4XL, right: .gap4XL)
        let photoCenterFrameAspectRatio: CGFloat = 0.82
        let tipViewTopOffset: CGFloat = .gapL
        let tipViewMinBottomTopOffset: CGFloat = .gapM
    }
}

