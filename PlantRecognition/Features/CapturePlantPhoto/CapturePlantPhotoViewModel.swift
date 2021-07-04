//
//  Created by Igor Kasyanenko on 27.06.2021.
//

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
            with: .init(
                photoFrameModel: .init(
                    photoFocusTintModel: buildPhotoFocusTintModel(),
                    bottomPanelModel: buildBottomPanelModel()
                )
            )
        )
    }
    
    func buildPhotoFocusTintModel() -> CapturePlantPhotoFocusTintView.Model {
        return .init(
            tip: .init(title: L10n.TakePhoto.TopHint.placePlantInFrame),
            state: .default
        )
    }
    
    func buildBottomPanelModel() -> CapturePlantBottomPanelView.Model {
        return .init(
            takePhotoButtonAction: { [weak self] in
                
            },
            selectImageFromGalleryModel: .init(
                style: .placeholder,
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
