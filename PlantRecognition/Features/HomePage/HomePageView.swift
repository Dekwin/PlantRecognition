//
//  HomePageView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.05.2021.
//

import Foundation
import UIKit
import SnapKit

final class HomePageView: UIView {
    private var actions: Actions?
    private lazy var selectedImageView: UIImageView = UIImageView()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select plant photo to recognize", for: .normal)
        button.addTarget(self, action: #selector(selectPhotoTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset photo", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(resetPhotoTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var photoButtonsStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                selectPhotoButton,
                resetPhotoButton
            ]
        )
        stack.spacing = 20
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var recognizePlantButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recognize plant!", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(recognizePhotoTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var plantNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.isHidden = true
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(model: Model) {
        actions = model.actions
        
        let plantImageNotSelected = model.selectedImage == nil
        selectedImageView.image = model.selectedImage
        selectedImageView.isHidden = plantImageNotSelected
        resetPhotoButton.isHidden = plantImageNotSelected
        recognizePlantButton.isHidden = plantImageNotSelected
        
        let plantTitleNotSelected = model.plantDescription?.title == nil
        plantNameLabel.text = model.plantDescription?.title
        plantNameLabel.isHidden = plantImageNotSelected || plantTitleNotSelected
    }
    
    @objc
    private func selectPhotoTouched() {
        actions?.selectPhotoButtonTouched()
    }
    
    @objc
    private func resetPhotoTouched() {
        actions?.resetPhotoButtonTouched()
    }
    
    @objc
    private func recognizePhotoTouched() {
        actions?.recognizePhotoButtonTouched()
    }
}

extension HomePageView {
    struct Model {
        let actions: Actions
        let selectedImage: UIImage?
        let plantDescription: PlantDescription?
    }
    
    struct Actions {
        let selectPhotoButtonTouched: Action
        let resetPhotoButtonTouched: Action
        let recognizePhotoButtonTouched: Action
    }
    
    struct PlantDescription {
        let title: String?
    }
}

// MARK: - Private methods

private extension HomePageView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        addSubviews(
            selectedImageView,
            photoButtonsStackView,
            recognizePlantButton,
            plantNameLabel
        )
        selectedImageView.contentMode = .scaleAspectFit
    }

    func setupConstraints() {
        photoButtonsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        recognizePlantButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoButtonsStackView.snp.bottom)
        }
        
        plantNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recognizePlantButton.snp.bottom)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(300)
            make.bottom.equalTo(photoButtonsStackView.snp.top)
        }
    }
}
