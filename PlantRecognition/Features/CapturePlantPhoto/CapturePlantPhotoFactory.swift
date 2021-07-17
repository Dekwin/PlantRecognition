//
//  Created by Igor Kasyanenko on 27.06.2021.
//

import UIKit

protocol CapturePlantPhotoFactoryProtocol: AnyObject {
    func create() -> UIViewController
}

final class CapturePlantPhotoFactory: CapturePlantPhotoFactoryProtocol {
    func create() -> UIViewController {
        let transitionHandler = TransitionableProxy()
        
        let router = CapturePlantPhotoRouter(transitionHandler: transitionHandler)
        let recognitionProxy = PlantRecognitionServiceProxyFactory().create(
            isDemo: DemoHelper.shared.isDemoMode
        )
        let libraryImagePicker = LibraryImagePicker()
        let viewModel = CapturePlantPhotoViewModel(
            deps: .init(
                router: router,
                plantRecognitionRetryWorker: PlantRecognitionRetryWorker(plantRecognitionServiceProxy: recognitionProxy),
                capturePlantPhotoLivePreviewWorker: CapturePlantPhotoLivePreviewWorker(),
                libraryImagePicker: libraryImagePicker
            )
        )
        
        let controller = CapturePlantPhotoViewController(viewModel: viewModel)
        libraryImagePicker.presentingViewController = controller
        
        viewModel.view = controller
        transitionHandler.wrapped = controller
        
        return controller
    }
}
