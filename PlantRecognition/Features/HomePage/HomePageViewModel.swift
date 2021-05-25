//
//  HomePageViewModel.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 24.05.2021.
//

import Foundation
import Combine

protocol HomePageViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class HomePageViewModel: HomePageViewModelProtocol {
    weak var view: HomePageViewControllerProtocol?
    private var cancelBag = Set<AnyCancellable>()
    private let router: HomePageRouter
    private let imagePickerManager: ImagePickerManagerProtocol
    
    init(
        router: HomePageRouter,
        imagePickerManager: ImagePickerManagerProtocol
    ) {
        self.router = router
        self.imagePickerManager = imagePickerManager
    }
    
    func viewLoaded() {
        setupBindings()
    }
    
}

private extension HomePageViewModel {
    func setupBindings() {
        guard let bindings = view?.bindings else { return }
        
        bindings
            .selectPhotoButtonTouched
            .flatMap { [imagePickerManager] _ in
                imagePickerManager.pickImage()
            }
            .subscribe(bindings.selectedImage)
            .store(in: &cancelBag)
    }
}
