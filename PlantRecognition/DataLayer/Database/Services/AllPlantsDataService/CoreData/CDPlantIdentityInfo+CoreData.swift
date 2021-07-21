//
//  PlantIdentityInfo+CoreData.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.07.2021.
//

import Foundation
import CoreData
import UIKit

extension CDPlantIdentityInfo {
    func update(with plant: PlantIdentityInfo) {
        id = plant.id
        
        switch plant.thumb {
        case .url(let imageUrl, _):
            thumbImageData = nil
            thumb = imageUrl
        case .image(let image):
            thumbImageData = image.jpegData(compressionQuality: 1)
            thumb = nil
        case nil:
            thumbImageData = nil
            thumb = nil
        }
        
        name = plant.name
        botanicalName = plant.botanicalName
        descriptionText = plant.description
    }
    
    func toDTO() -> PlantIdentityInfo? {
        guard let id = id, let name = name else { return nil }
        
        let thumb: ImageType?
        if let thumbUrl = self.thumb {
            thumb = .url(imageUrl: thumbUrl, placeholderImage: Asset.Images.Components.plantPlaceholderImage.image)
        } else if let thumbImageData = self.thumbImageData, let image = UIImage(data: thumbImageData) {
            thumb = .image(image)
        } else {
            thumb = nil
        }
        
        return .init(
            id: id,
            thumb: thumb,
            name: name,
            botanicalName: botanicalName,
            description: descriptionText
        )
    }
}
