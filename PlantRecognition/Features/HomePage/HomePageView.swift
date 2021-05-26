//
//  HomePageView.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 23.05.2021.
//

import Foundation
import UIKit
import SnapKit
import CombineCocoa
import Combine

final class HomePageView: UIView {
    private var cancelBag = Set<AnyCancellable>()
    
    var bindings: Bindings {
        .init(
            selectPhotoButtonTouched: selectPhotoButton.tapPublisher,
            resetPhotoButtonTouched: resetPhotoButton.tapPublisher,
            recognizePhotoButtonTouched: recognizePlantButton.tapPublisher,
            selectedImage: selectedPhotoSubject,
            plantDescription: plantDescriptionSubject
        )
    }
    
    private let selectedPhotoSubject = PassthroughSubject<UIImage?, Never>()
    private let plantDescriptionSubject = PassthroughSubject<PlantDescription?, Never>()
    
    private lazy var selectedImageView: UIImageView = UIImageView()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select plant photo to recognize", for: .normal)
        return button
    }()
    
    private lazy var resetPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset photo", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
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
}

extension HomePageView {
    struct Bindings {
        let selectPhotoButtonTouched: AnyPublisher<Void, Never>
        let resetPhotoButtonTouched: AnyPublisher<Void, Never>
        let recognizePhotoButtonTouched: AnyPublisher<Void, Never>
        let selectedImage: PassthroughSubject<UIImage?, Never>
        let plantDescription: PassthroughSubject<PlantDescription?, Never>
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
        setupBindings()
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
    
    func setupBindings() {
        selectedPhotoSubject
            .assign(to: \.image, on: selectedImageView)
            .store(in: &cancelBag)
        
        let photoNotSelected = selectedPhotoSubject
            .map { $0 == nil }
        
        photoNotSelected
            .assign(to: \.isHidden, on: resetPhotoButton)
            .store(in: &cancelBag)
        
        photoNotSelected
            .assign(to: \.isHidden, on: recognizePlantButton)
            .store(in: &cancelBag)
        
        let plantTitle = plantDescriptionSubject
            .map { $0?.title }
        
        plantTitle
            .assign(to: \.text, on: plantNameLabel)
            .store(in: &cancelBag)
        
        let plantTitleNotSelected = plantTitle
            .map { $0 == nil }
        
        Publishers
            .CombineLatest(plantTitleNotSelected, photoNotSelected)
            .map { $0 || $1 }
            .assign(to: \.isHidden, on: plantNameLabel)
            .store(in: &cancelBag)
    }
}
