//
//  HomePageViewModel.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 24.05.2021.
//

import Foundation
import Combine
import UIKit

protocol HomePageViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class HomePageViewModel: HomePageViewModelProtocol {
    weak var view: HomePageViewControllerProtocol?

    private let deps: Deps
    
    private var cancelBag = Set<AnyCancellable>()
    private let currentSelectedImageSubject = CurrentValueSubject<UIImage?, Never>(nil)
    
    init(
        deps: Deps
    ) {
        self.deps = deps
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
            .flatMap { [deps] _ in
                deps.imagePickerManager.pickImage()
            }
            .subscribe(currentSelectedImageSubject)
            .store(in: &cancelBag)
        
        currentSelectedImageSubject
            .subscribe(bindings.selectedImage)
            .store(in: &cancelBag)
        
        
        bindings
            .resetPhotoButtonTouched
            .map { nil }
            .subscribe(currentSelectedImageSubject)
            .store(in: &cancelBag)
        
        bindings
            .resetPhotoButtonTouched
            .map { nil }
            .subscribe(bindings.plantDescription)
            .store(in: &cancelBag)
        
        
        bindings
            .recognizePhotoButtonTouched
            .combineLatest(currentSelectedImageSubject)
            .removeDuplicates { $0.1 == $1.1 }
            .compactMap { $0.1 }
            .flatMap { [deps] in
                deps
                    .plantRecognitionServiceProxy
                    .recognize(image: $0)
                    .replaceError(with: .init(scientificName: ""))
            }
            .map {
                HomePageView.PlantDescription(
                    title: "Plant name: \($0.scientificName ?? "-")"
                )
            }
            .replaceError(with: nil)
            .subscribe(bindings.plantDescription)
            .store(in: &cancelBag)
        
    }
}

extension HomePageViewModel {
    struct Deps {
        let router: HomePageRouter
        let imagePickerManager: ImagePickerManagerProtocol
        let plantRecognitionServiceProxy: PlantRecognitionServiceProxyProtocol
    }
}
