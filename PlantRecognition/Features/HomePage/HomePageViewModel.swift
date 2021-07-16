//
//  HomePageViewModel.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 24.05.2021.
//

import Foundation
import UIKit

protocol HomePageViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class HomePageViewModel: HomePageViewModelProtocol {
    weak var view: HomePageViewControllerProtocol?
    private var selectedPlantImage: UIImage?
    private var recognizeResult: PlantRecognitionServiceProxyResult?

    private let deps: Deps
    
    init(
        deps: Deps
    ) {
        self.deps = deps
    }
    
    func viewLoaded() {
        updateView()
    }
}

private extension HomePageViewModel {
    func updateView() {
        view?.update(
            model: .init(
                actions: .init(
                    selectPhotoButtonTouched: { [weak self] in
                        self?.deps.imagePickerManager.pickImage({ image in
                            self?.resetSelectedImage(to: image)
                        })
                    },
                    resetPhotoButtonTouched: { [weak self] in
                        guard let self = self else { return }
                        self.resetSelectedImage(to: nil)
                    },
                    recognizePhotoButtonTouched: { [weak self] in
                        guard
                            let self = self,
                            let image = self.selectedPlantImage
                        else { return }
                        
                        self.view?.setLoading(true)
                        self.deps.plantRecognitionServiceProxy.recognize(
                            image: image
                        ) { [weak self] result in
                            guard let self = self else { return }
                            
                            self.view?.setLoading(false)
                            switch result {
                            case .success(let proxyResult):
                                self.recognizeResult = proxyResult
                                self.updateView()
                            break
                            case .failure(let error):
                                self.view?.presentAlert(error: error)
                            }
                        }
                    }
                ),
                selectedImage: selectedPlantImage,
                recognitionResult: mapProxyResult(recognizeResult)
            )
        )
    }
    
    private func resetSelectedImage(to image: UIImage?) {
        selectedPlantImage = image
        recognizeResult = nil
        updateView()
    }
    
    private func mapProxyResult(_ recognizeResult: PlantRecognitionServiceProxyResult?) -> PlantRecognitionResultView.Model? {
        guard let recognizeResult = recognizeResult else {
            return nil
        }
        
        switch recognizeResult.resultType {
        case .notRecognizedError:
            return .init(
                recognitionResultType: .many(
                    descriptions: []
                )
            )
        case .recognized(let plantIdentity, let probability):
            return .init(
                recognitionResultType: .one(
                    description: PlantRecognitionResultView.PlantDescription(name: plantIdentity.name, probability: probability ?? 0)
                )
            )
        }

        
        
    }
}

extension HomePageViewModel {
    struct Deps {
        let router: HomePageRouter
        let imagePickerManager: ImagePickerManagerProtocol
        let plantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol
    }
}
