//
//  UITableView+CellRegistration.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 25.06.2021.
//

import Foundation
import UIKit

extension UITableView {
    func registerCellIdentifier(for cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
}
