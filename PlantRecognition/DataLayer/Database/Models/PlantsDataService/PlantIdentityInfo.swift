//
//  Created by Igor Kasyanenko on 04.07.2021.
//

import Foundation
import UIKit

struct PlantIdentityInfo {
    let id: String
    let updated: Date?
    let image: ImageType?
    let name: String
    let botanicalName: String?
    let commonNames: [String]
    let description: String?
    let synonyms: [String]
    let family: String?
    let genus: String?
    let emptyData: Bool
    let thumb: ImageType?
    let images: [ImageType]
    let profile: [ProfileItem]
    let data: [DataItem]
    let features: [FeatureItem]
    let tags: [String]
    
    init(
        id: String,
        updated: Date? = nil,
        image: ImageType? = nil,
        name: String,
        botanicalName: String? = nil,
        commonNames: [String] = [],
        description: String? = nil,
        synonyms: [String] = [],
        family: String? = nil,
        genus: String? = nil,
        emptyData: Bool = false,
        thumb: ImageType? = nil,
        images: [ImageType] = [],
        profile: [PlantIdentityInfo.ProfileItem] = [],
        data: [PlantIdentityInfo.DataItem] = [],
        features: [PlantIdentityInfo.FeatureItem] = [],
        tags: [String] = []
    ) {
        self.id = id
        self.updated = updated
        self.image = image
        self.name = name
        self.botanicalName = botanicalName
        self.commonNames = commonNames
        self.description = description
        self.synonyms = synonyms
        self.family = family
        self.genus = genus
        self.emptyData = emptyData
        self.thumb = thumb
        self.images = images
        self.profile = profile
        self.data = data
        self.features = features
        self.tags = tags
    }
}

extension PlantIdentityInfo {
    struct ProfileItem {
        let title: String
        let description: String?
    }
}

extension PlantIdentityInfo {
    struct DataItem {
        let icon: ImageType?
        let title: String
        let description: String?
        let images: [ImageType]
        let `extension`: Extension?
    }
}

extension PlantIdentityInfo.DataItem {
    struct Extension {
        let type: String
        let data: Data
    }
}

extension PlantIdentityInfo.DataItem.Extension {
    struct Data {
        let text: String
        let icon: ImageType?
        let unit: String?
        let unitCount: Int?
        
    }
}

extension PlantIdentityInfo {
    struct FeatureItem {
        let type: String
        let value: [String: Any]
    }
}
