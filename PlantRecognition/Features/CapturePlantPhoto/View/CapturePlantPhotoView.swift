//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import UIKit

final class CapturePlantPhotoView: UIView {
    private let appearance = Appearance()
    
    private lazy var navigationGradientView = GradientView(
        colors: appearance.navigationGradientColors,
        locations: [0, 1]
    )
    
    private lazy var photoTintView = CapturePlantPhotoFocusTintView()
    private lazy var retryView: CapturePlantPhotoRetryView = {
       let view = CapturePlantPhotoRetryView()
        view.isHidden = true
        return view
    }()
    
    private lazy var takePhotoBottomPanelView = CapturePlantBottomPanelView()
    private lazy var plantRecognizedBottomPanelView: CapturePlantRecognizedBottomPanelView = {
        let view = CapturePlantRecognizedBottomPanelView()
        view.isHidden = true
        return view
    }()
    
    private lazy var safeAreaBottomPanelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var videoCaptureView: UIView = {
        let view = UIImageView(image: Asset.Images.DemoImages.cactus1.image)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        updateContent(with: model.contentState)
        updateBottomPanel(with: model.bottomPanelState)
    }
    
    private func updateContent(with state: ContentState) {
        switch state {
        case .photoFocusTint(let model):
            photoTintView.update(with: model)
            
            photoTintView.isHidden = false
            retryView.isHidden = true
        case .retry(let model):
            retryView.update(with: model)
            
            photoTintView.isHidden = true
            retryView.isHidden = false
        }
    }
    
    private func updateBottomPanel(with state: BottomPanelState) {
        switch state {
        case .takePhoto(let model):
            takePhotoBottomPanelView.update(with: model)
            
            takePhotoBottomPanelView.isHidden = false
            plantRecognizedBottomPanelView.isHidden = true
        case .plantRecognized(let model):
            plantRecognizedBottomPanelView.update(with: model)
            
            takePhotoBottomPanelView.isHidden = true
            plantRecognizedBottomPanelView.isHidden = false
        case .plantRecognitionError:
            // TODO: Implement
        break
        }
    }
}

// MARK: - Private methods
private extension CapturePlantPhotoView {
    func commonInit() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubviews(
            videoCaptureView,
            photoTintView,
            retryView,
            navigationGradientView,
            safeAreaBottomPanelView,
            takePhotoBottomPanelView,
            plantRecognizedBottomPanelView
        )
        videoCaptureView.clipsToBounds = true
    }
    
    func setupConstraints() {
        navigationGradientView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.top).inset(appearance.navigationGradientBottonInset)
        }
        
        photoTintView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        retryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        videoCaptureView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        takePhotoBottomPanelView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(appearance.takePhotoBottomPanelViewHeight)
            make.bottom.equalTo(safeAreaBottomPanelView.snp.top)
        }
        
        plantRecognizedBottomPanelView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(appearance.plantRecognizedBottomPanelViewHeight)
            make.bottom.equalTo(safeAreaBottomPanelView.snp.top)
        }
        
        safeAreaBottomPanelView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - Model
extension CapturePlantPhotoView {
    struct Model {
        let contentState: ContentState
        let bottomPanelState: BottomPanelState
    }
    
    enum ContentState {
        case photoFocusTint(CapturePlantPhotoFocusTintView.Model)
        case retry(CapturePlantPhotoRetryView.Model)
    }
    
    enum BottomPanelState {
        case takePhoto(CapturePlantBottomPanelView.Model)
        case plantRecognized(CapturePlantRecognizedBottomPanelView.Model)
        case plantRecognitionError
    }
}

// MARK: - Appearance
private extension CapturePlantPhotoView {
    struct Appearance {
        let navigationGradientBottonInset: CGFloat = .gapL
        let navigationGradientColors: [UIColor] = [
            Asset.Colors.mainGreen.color.withAlphaComponent(0.6),
            Asset.Colors.mainGreen.color.withAlphaComponent(0)
        ]
        let takePhotoBottomPanelViewHeight: CGFloat = 144.0
        let plantRecognizedBottomPanelViewHeight: CGFloat = 170.0
    }
}

