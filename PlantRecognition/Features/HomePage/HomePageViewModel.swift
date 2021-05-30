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
                            self?.selectedPlantImage = image
                            self?.updateView()
                        })
                    },
                    resetPhotoButtonTouched: { [weak self] in
                        guard let self = self else { return }
                        self.selectedPlantImage = nil
                        self.updateView()
                    },
                    recognizePhotoButtonTouched: { [weak self] in
                        guard
                            let self = self,
                            let image = self.selectedPlantImage
                        else { return }
                        
                        self.deps.plantRecognitionServiceProxy.recognize(
                            image: image
                        ) { [weak self] result in
                            guard let self = self else { return }
                            
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
                plantDescription: mapProxyResultToPlantDescription(recognizeResult)
            )
        )
    }
    
    private func mapProxyResultToPlantDescription(_ recognizeResult: PlantRecognitionServiceProxyResult?) -> HomePageView.PlantDescription? {
        guard let recognizeResult = recognizeResult else {
            return nil
        }
        
        return HomePageView.PlantDescription(
            title: "Plant name: \(recognizeResult.scientificName ?? "-")"
        )
    }
}

extension HomePageViewModel {
    struct Deps {
        let router: HomePageRouter
        let imagePickerManager: ImagePickerManagerProtocol
        let plantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol
    }
}
