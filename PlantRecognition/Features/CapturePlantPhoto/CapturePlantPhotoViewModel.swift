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
    
    private func updateView() {
        view?.update(
            with: .init(
                photoFrameModel: .init(
                    photoFocusTintModel: .init(tip: .init(title: "scanning"), state: .default)
                )
            )
        )
    }
}
