//
//  LibraryImagePicker.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 17.07.2021.
//

import Foundation
import UIKit
import Photos

protocol LibraryImagePickerProtocol: AnyObject {
    func pickImage(callback: @escaping ((_ pickedImage: Result<UIImage, Error>) -> Void))
    func loadLastImageThumb(requestLibraryAccessIfNotGranted: Bool, completion: @escaping (UIImage?) -> ())
}

class LibraryImagePicker: NSObject, LibraryImagePickerProtocol {
    weak var presentingViewController: UIViewController?
    private var pickImageCallback: ((Result<UIImage, Error>) -> Void)?
    
    func pickImage(callback: @escaping ((Result<UIImage, Error>) -> Void)) {
        pickImageCallback = callback
        
        checkPhotoLibraryPermission(requestAccessIfNotGranted: true) { [weak self] isAccessGranted in
            if isAccessGranted && UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self?.presentingViewController?.present(imagePicker, animated: true, completion: nil)
            } else {
                callback(.failure(PickerError.dontHaveLibraryPermission))
            }
        }
    }
    
    func loadLastImageThumb(
        requestLibraryAccessIfNotGranted: Bool,
        completion: @escaping (UIImage?) -> ()
    ) {
        checkPhotoLibraryPermission(requestAccessIfNotGranted: requestLibraryAccessIfNotGranted) { [weak self] isAccessGranted in
            if isAccessGranted {
                self?.loadLastImageThumb(completion: completion)
            } else {
                completion(nil)
            }
        }
    }
    
    private func loadLastImageThumb(completion: @escaping (UIImage?) -> ()) {
        let imgManager = PHImageManager.default()
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        if let last = fetchResult.lastObject {
            let scale = UIScreen.main.scale
            let size = CGSize(width: 100 * scale, height: 100 * scale)
            let options = PHImageRequestOptions()
            
            // For fast load
            options.deliveryMode = .fastFormat
            options.resizeMode = .fast
            
            imgManager.requestImage(
                for: last,
                targetSize: size,
                contentMode: PHImageContentMode.aspectFill,
                options: options,
                resultHandler: { (image, _) in
                    completion(image)
                }
            )
        } else {
            completion(nil)
        }
    }
    
    private func checkPhotoLibraryPermission(
        requestAccessIfNotGranted: Bool,
        completion: @escaping (_ isAccessGranted: Bool) -> Void
    ) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .limited:
            completion(true)
        case .denied, .restricted :
            completion(false)
        //handle denied status
        case .notDetermined:
            if requestAccessIfNotGranted {
                // ask for permissions
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        switch status {
                        case .authorized, .limited:
                            completion(true)
                        case .denied, .restricted:
                            completion(false)
                        case .notDetermined:
                            completion(false)
                        @unknown default:
                            completion(false)
                        }
                    }
                }
            } else {
                completion(false)
            }
        @unknown default:
            completion(false)
        }
    }
}

extension LibraryImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            pickImageCallback?(.failure(PickerError.incorrectImageFileSelected))
            return
        }
        
        pickImageCallback?(.success(image))
    }
}


extension LibraryImagePicker {
    enum PickerError: Error {
        case incorrectImageFileSelected
        case dontHaveLibraryPermission
    }
}
