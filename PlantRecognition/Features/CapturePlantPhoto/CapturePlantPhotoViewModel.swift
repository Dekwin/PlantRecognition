//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import UIKit
import AVFoundation

protocol CapturePlantPhotoViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class CapturePlantPhotoViewModel {
    weak var view: CapturePlantPhotoViewProtocol?
    
    private let deps: Deps
    
    private lazy var state: State = buildInitialState() {
        didSet {
            updateView()
        }
    }
    
    init(
        deps: Deps
    ) {
        self.deps = deps
        deps.capturePlantPhotoLivePreviewWorker.delegate = self
    }
}

// MARK: - CapturePlantPhotoViewModelProtocol
extension CapturePlantPhotoViewModel: CapturePlantPhotoViewModelProtocol {
    func viewLoaded() {
        updateView()
        setupLiveCameraPreview()
    }
    
    private func runTestFlow() {
        // Test
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state.content = .recognizing(recognizingImage: Asset.Images.DemoImages.cactus1.image)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.state = .init(
                    content: .retry(recognizedImage: Asset.Images.DemoImages.cactus1.image, retriesLeft: 3),
                    bottomPanel: .plantRecognized(plantIdentity: .init(id: "1", image: Asset.Images.DemoImages.cactus1.image, name: "Sansevieria", description: "Sansevieria is a genus of stemless evergreen perennial herbaceous plants of the Asparagaceae family."))
                )
            }
        }
    }
    
    private func setupLiveCameraPreview() {
        deps.capturePlantPhotoLivePreviewWorker.initializeAndRequestCameraAccess { [weak self] result in
            switch result {
            case .success:
                self?.deps.capturePlantPhotoLivePreviewWorker.startVideoPreview { [weak self] in
                    guard let self = self else { return }
                    
                    self.setupInitialState()
                }
            case .failure(let error):
                self?.view?.presentAlert(error: error)
            }
        }
    }
    
    private func setupInitialState() {
        state = buildInitialState()
    }
    
    private func buildInitialState() -> State {
        .init(
            content: .takePhotoTint(videoPreviewLayer: deps.capturePlantPhotoLivePreviewWorker.videoPreviewLayer),
            bottomPanel: .takePhotoButtons
        )
    }
}

extension CapturePlantPhotoViewModel: CapturePlantPhotoLivePreviewWorkerDelegate {
    func photoCaptured(result: Result<UIImage, Error>) {
        switch result {
        case .success(let image):
            state = .init(content: .recognizing(recognizingImage: image), bottomPanel: .takePhotoButtons)
            self.view?.setInterface(isLocked: true)
            deps.plantRecognitionRetryWorker.recognize(sourceImage: image) { [weak self] result in
                guard let self = self else { return }
                self.view?.setInterface(isLocked: false)
                switch result {
                case .success(let recognitionResult):
                    let retriesLeft = recognitionResult.recognitionRetriesLeft
                    switch recognitionResult.recognitionResult.resultType {
                    case .recognized(let plantIdentity, _):
                        self.state = .init(
                            content: .retry(recognizedImage: image, retriesLeft: retriesLeft),
                            bottomPanel: .plantRecognized(plantIdentity: plantIdentity)
                        )
                    case .notRecognizedError:
                        self.state = .init(
                            content: .retry(recognizedImage: image, retriesLeft: retriesLeft),
                            bottomPanel: .recognitionError
                        )
                    }
                   
                case .failure(let error):
                    self.view?.presentAlert(error: error)
                }
            }
        case .failure(let error):
            view?.presentAlert(error: error)
        }
    }
}

// MARK: - Button handlers
private extension CapturePlantPhotoViewModel {
    func selectPhotoFromGalleryTouched() {
        
    }
    
    func makeCameraPhotoTouched() {
        deps.capturePlantPhotoLivePreviewWorker.capturePhoto()
    }
    
    func retryTouched() {
        let userCanRetry = deps.plantRecognitionRetryWorker.hasRecognizePlantRetryAttempts
        
        if userCanRetry {
            setupInitialState()
        } else {
            // Do nothing
        }
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
        case .takePhotoTint(let videoPreviewLayer):
            return .photoFocusTint(buildReadyToTakePhotoFocusTintModel(videoPreviewLayer: videoPreviewLayer))
        case .recognizing(let image):
            return .photoFocusTint(buildRecognizingPhotoFocusTintModel(bgImage: image))
        case .retry(let image, let retriesLeft):
            return .retry(buildRetryModel(bgImage: image, retriesLeft: retriesLeft))
        }
    }
    
    func buildRetryModel(bgImage: UIImage, retriesLeft: Int) -> CapturePlantPhotoRetryView.Model {
        return .init(
            bgImage: bgImage,
            tip: .init(title: L10n.TakePhoto.RetryHint.attempts(retriesLeft)),
            retryButtonAction: { [weak self] in
                self?.retryTouched()
            }
        )
    }
    
    func buildReadyToTakePhotoFocusTintModel(
        videoPreviewLayer: AVCaptureVideoPreviewLayer
    ) -> CapturePlantPhotoFocusTintView.Model {
        return .init(
            tip: .init(title: L10n.TakePhoto.TopHint.placePlantInFrame),
            state: .readyToTakePhoto(.init(videoPreviewLayer: videoPreviewLayer))
        )
    }
    
    func buildRecognizingPhotoFocusTintModel(bgImage: UIImage) -> CapturePlantPhotoFocusTintView.Model {
        return .init(
            tip: .init(title: L10n.TakePhoto.TopHint.scanning),
            state: .scanning(.init(image: bgImage))
        )
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
        case takePhotoTint(videoPreviewLayer: AVCaptureVideoPreviewLayer)
        case recognizing(recognizingImage: UIImage)
        case retry(recognizedImage: UIImage, retriesLeft: Int)
    }
    
    enum BottomPanelState {
        case takePhotoButtons
        case plantRecognized(plantIdentity: PlantIdentityInfo)
        case recognitionError
    }
    
    struct Deps {
        let router: CapturePlantPhotoRouterProtocol
        let plantRecognitionRetryWorker: PlantRecognitionRetryWorkerProtocol
        let capturePlantPhotoLivePreviewWorker: CapturePlantPhotoLivePreviewWorkerProtocol
    }
}
