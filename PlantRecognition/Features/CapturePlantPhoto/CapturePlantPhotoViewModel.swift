//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import UIKit

protocol CapturePlantPhotoViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class CapturePlantPhotoViewModel {
    private let router: CapturePlantPhotoRouterProtocol
    weak var view: CapturePlantPhotoViewProtocol?
    
    init(
        router: CapturePlantPhotoRouterProtocol
    ) {
        self.router = router
    }
}

// MARK:  CapturePlantPhotoViewModelProtocol
extension CapturePlantPhotoViewModel: CapturePlantPhotoViewModelProtocol {
    func viewLoaded() {
       updateView()
    }
}


// MARK:  Helpers
private extension CapturePlantPhotoViewModel {
    
    func updateView() {
        view?.update(
            with: .init(contentModel: buildContentModel())
        )
    }
    
    // MARK: - Content
    
    func buildContentModel() -> CapturePlantPhotoView.Model {
        return .init(
            contentState: buildContentState(),
            bottomPanelState: buildBottomPanelState()
        )
    }
    
    func buildContentState() -> CapturePlantPhotoView.ContentState {
        return .photoFocusTint(buildPhotoFocusTintModel())
    }
    
    func buildPhotoFocusTintModel() -> CapturePlantPhotoFocusTintView.Model {
        return .init(
            tip: .init(title: L10n.TakePhoto.TopHint.placePlantInFrame),
            state: .scanning
        )
    }
    
    // MARK: - Bottom Panel
    
    func buildBottomPanelState() -> CapturePlantPhotoView.BottomPanelState {
        return .takePhoto(buildTakePhotoBottomPanelModel()) // .plantRecognized(buildPlantReognizedBottomPanelModel())
    }
    
    func buildPlantReognizedBottomPanelModel() -> CapturePlantRecognizedBottomPanelView.Model {
        return .init(
            image: UIImage(),
            title: "Sansevieria",
            subtitle: "Sansevieria is a genus of stemless evergreen perennial herbaceous plants of the Asparagaceae family.",
            nextButtonAction: {}
        )
    }
    
    func buildTakePhotoBottomPanelModel() -> CapturePlantBottomPanelView.Model {
        return .init(
            takePhotoButtonAction: { [weak self] in
                
            },
            selectImageFromGalleryModel: .init(
                style: .placeholderImage,
                tapAction: { [weak self] in
                    
                }
            ),
            photoAttemptsVipModel: buildPhotoAttemptsVipModel()
        )
    }
    
    func buildPhotoAttemptsVipModel() -> PhotoAttemptsVipView.Model? {
        return .init(
            tapAction: { [weak self] in
                
            },
            style: .fullAccess
        )
    }
    
}
