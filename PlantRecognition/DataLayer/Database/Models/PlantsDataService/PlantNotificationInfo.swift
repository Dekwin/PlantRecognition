//
//  PlantNotificationInfo.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation
import UIKit

struct PlantNotificationInfo {
    let type: NotificationType
}

extension PlantNotificationInfo {
    enum NotificationType {
        case fertilize
        case water
        case repot
    }
}

extension PlantNotificationInfo.NotificationType {
    var image: UIImage {
        switch self {
        case .fertilize:
            return Asset.Images.Iconly.greenFertilizer.image
        case .repot:
            return Asset.Images.Iconly.greenPots.image
        case .water:
            return Asset.Images.Iconly.greenDroplet.image
        }
    }
}
