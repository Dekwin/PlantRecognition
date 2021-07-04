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
    
    private lazy var bottomPanelView = CapturePlantBottomPanelView()
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
        photoTintView.update(with: model.photoFocusTintModel)
        bottomPanelView.update(with: model.bottomPanelModel)
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
            navigationGradientView,
            safeAreaBottomPanelView,
            bottomPanelView
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
        videoCaptureView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bottomPanelView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(appearance.bottomPanelViewHeight)
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
        let photoFocusTintModel: CapturePlantPhotoFocusTintView.Model
        let bottomPanelModel: CapturePlantBottomPanelView.Model
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
        let bottomPanelViewHeight: CGFloat = 144.0
    }
}

