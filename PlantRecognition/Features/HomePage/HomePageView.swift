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
            selectedImage: selectedPhotoSubject
        )
    }
    
    private let selectedPhotoSubject = PassthroughSubject<UIImage?, Never>()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select plant photo to recognize", for: .normal)
        return button
    }()
    
    private lazy var selectedImageView: UIImageView = UIImageView()
    
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
        let selectedImage: PassthroughSubject<UIImage?, Never>
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
            selectPhotoButton,
            selectedImageView
        )
        selectedImageView.contentMode = .scaleAspectFit
    }

    func setupConstraints() {
        selectPhotoButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(300)
            make.bottom.equalTo(selectPhotoButton.snp.top)
        }
    }
    
    func setupBindings() {
        selectedPhotoSubject
            .assign(to: \.image, on: selectedImageView)
            .store(in: &cancelBag)
    }
}
