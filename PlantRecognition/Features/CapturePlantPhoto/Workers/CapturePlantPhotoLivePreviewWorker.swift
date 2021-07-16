//
//  CapturePlantPhotoLivePreviewWorker.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 16.07.2021.
//

import Foundation
import AVFoundation
import UIKit

/// Handles video preview
protocol CapturePlantPhotoLivePreviewWorkerProtocol: AnyObject {
    var delegate: CapturePlantPhotoLivePreviewWorkerDelegate? { get set }
    var videoPreviewLayer: AVCaptureVideoPreviewLayer { get }
    /// Must be called firstly
    func initializeAndRequestCameraAccess(completion: @escaping (Result<Void, Error>) -> Void)
    
    func capturePhoto()
    
    func startVideoPreview(completion: @escaping Action)
    func stopVideoPreview(completion: @escaping Action)
}

protocol CapturePlantPhotoLivePreviewWorkerDelegate: AnyObject {
    func photoCaptured(result: Result<UIImage, Error>)
}

class CapturePlantPhotoLivePreviewWorker: NSObject {
    weak var delegate: CapturePlantPhotoLivePreviewWorkerDelegate?
    
    private lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = .high
        
        return session
    }()
    private var stillImageOutput: AVCapturePhotoOutput = {
        let output = AVCapturePhotoOutput()
        return output
    }()
    private(set) lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer = {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        
        return videoPreviewLayer
    }()
    
  
}

extension CapturePlantPhotoLivePreviewWorker: CapturePlantPhotoLivePreviewWorkerProtocol {
    
    func initializeAndRequestCameraAccess(completion: @escaping (Result<Void, Error>) -> Void) {
        requestCameraAccess { [weak self] isAccessGranted in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard isAccessGranted else {
                    completion(.failure(LivePreviewError.noCameraAccess))
                    return
                }
                
                do {
                    try self.setup()
                    
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func startVideoPreview(completion: @escaping Action) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func stopVideoPreview(completion: @escaping Action) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.stopRunning()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func requestCameraAccess(completion: @escaping (_ isAccessGranted: Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            completion(true)
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        case .denied: // The user has previously denied access.
            completion(false)
        case .restricted: // The user can't grant access due to restrictions.
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    private func setup() throws {
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else {
            throw LivePreviewError.noCameraAccess
        }
        
        let input = try AVCaptureDeviceInput(device: backCamera)
        
        if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
            captureSession.addInput(input)
            captureSession.addOutput(stillImageOutput)
        }
        
        videoPreviewLayer.connection?.videoOrientation = .portrait
    }
}

extension CapturePlantPhotoLivePreviewWorker: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            delegate?.photoCaptured(result: .failure(error))
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else {
            delegate?.photoCaptured(result: .failure(LivePreviewError.capturePhotoError))
            return
        }
        
        delegate?.photoCaptured(result: .success(image))
    }
}

extension CapturePlantPhotoLivePreviewWorker {
    enum LivePreviewError: Error {
        case canNotInitializeCamera
        case noCameraAccess
        case capturePhotoError
    }
}
