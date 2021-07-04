//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import UIKit

protocol CapturePlantPhotoViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class CapturePlantPhotoViewModel {
    weak var view: CapturePlantPhotoViewProtocol?
    
    private let deps: Deps
    
    private lazy var state: State = .init(content: .takePhotoTint, bottomPanel: .takePhotoButtons) {
        didSet {
            updateView()
        }
    }
    
    init(
        deps: Deps
    ) {
        self.deps = deps
    }
}

// MARK: - CapturePlantPhotoViewModelProtocol
extension CapturePlantPhotoViewModel: CapturePlantPhotoViewModelProtocol {
    func viewLoaded() {
        updateView()
        
        // Test
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state.content = .recognizing
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.state = .init(
                    content: .retry(retriesLeft: 3),
                    bottomPanel: .plantRecognized(plantIdentity: .init(id: "1", image: Asset.Images.DemoImages.cactus1.image, name: "Sansevieria", description: "Sansevieria is a genus of stemless evergreen perennial herbaceous plants of the Asparagaceae family."))
                )
            }
        }
    }
}

// MARK: - Button handlers
private extension CapturePlantPhotoViewModel {
    func selectPhotoFromGalleryTouched() {
        
    }
    
    func makeCameraPhotoTouched() {
        
    }
    
    func retryTouched() {
        
    }
    
    func subscriptionsButtonTouched() {
        
    }
    
    func plantRecognizedNextButtonTouched(plantIdentity: PlantIdentityInfo) {
        
    }
}

// MARK: - Build models helpers
private extension CapturePlantPhotoViewModel {
    func updateView() {
        view?.update(
            with: .init(
                contentModel: buildContentModel(from: state)
            )
        )
    }
    
    // MARK: - Content
    
    func buildContentModel(from state: State) -> CapturePlantPhotoView.Model {
        return .init(
            contentState: buildContentState(from: state.content),
            bottomPanelState: buildBottomPanelState(from: state.bottomPanel)
        )
    }
    
    func buildContentState(from state: ContentState) -> CapturePlantPhotoView.ContentState {
        switch state {
        case .takePhotoTint:
            return .photoFocusTint(buildPhotoFocusTintModel(isRecognizing: false))
        case .recognizing:
            return .photoFocusTint(buildPhotoFocusTintModel(isRecognizing: true))
        case .retry(let retriesLeft):
            return .retry(buildRetryModel(retriesLeft: retriesLeft))
        }
    }
    
    func buildRetryModel(retriesLeft: Int) -> CapturePlantPhotoRetryView.Model {
        return .init(
            tip: .init(title: L10n.TakePhoto.RetryHint.attempts(retriesLeft)),
            retryButtonAction: { [weak self] in
                self?.retryTouched()
            }
        )
    }
    
    func buildPhotoFocusTintModel(isRecognizing: Bool) -> CapturePlantPhotoFocusTintView.Model {
        if isRecognizing {
            return .init(
                tip: .init(title: L10n.TakePhoto.TopHint.scanning),
                state: .scanning
            )
        } else {
            return .init(
                tip: .init(title: L10n.TakePhoto.TopHint.placePlantInFrame),
                state: .readyToTakePhoto
            )
        }
    }
    
    // MARK: - Bottom Panel
    
    func buildBottomPanelState(from state: BottomPanelState) -> CapturePlantPhotoView.BottomPanelState {
        
        switch state {
        case .takePhotoButtons:
            return .takePhoto(buildTakePhotoBottomPanelModel())
        case .plantRecognized(let plant):
            return .plantRecognized(buildPlantReognizedBottomPanelModel(plantIdentity: plant))
        case .recognitionError:
            return .plantRecognitionError
        }
    }
    
    func buildPlantReognizedBottomPanelModel(
        plantIdentity: PlantIdentityInfo
    ) -> CapturePlantRecognizedBottomPanelView.Model {
        return .init(
            image: plantIdentity.image,
            title: plantIdentity.name,
            subtitle: plantIdentity.description,
            nextButtonAction: { [weak self] in
                self?.plantRecognizedNextButtonTouched(plantIdentity: plantIdentity)
            }
        )
    }
    
    func buildTakePhotoBottomPanelModel() -> CapturePlantBottomPanelView.Model {
        return .init(
            takePhotoButtonAction: { [weak self] in
                self?.makeCameraPhotoTouched()
            },
            selectImageFromGalleryModel: .init(
                style: .placeholderImage,
                tapAction: { [weak self] in
                    self?.selectPhotoFromGalleryTouched()
                }
            ),
            photoAttemptsVipModel: buildPhotoAttemptsVipModel()
        )
    }
    
    func buildPhotoAttemptsVipModel() -> PhotoAttemptsVipView.Model? {
        return .init(
            tapAction: { [weak self] in
                self?.subscriptionsButtonTouched()
            },
            style: .fullAccess
        )
    }
}

// MARK: Deps and state
extension CapturePlantPhotoViewModel {
    struct State {
        var content: ContentState
        var bottomPanel: BottomPanelState
    }
    
    enum ContentState {
        case takePhotoTint
        case recognizing
        case retry(retriesLeft: Int)
    }
    
    enum BottomPanelState {
        case takePhotoButtons
        case plantRecognized(plantIdentity: PlantIdentityInfo)
        case recognitionError
    }
    
    struct Deps {
        let router: CapturePlantPhotoRouterProtocol
        let plantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol
    }
}
