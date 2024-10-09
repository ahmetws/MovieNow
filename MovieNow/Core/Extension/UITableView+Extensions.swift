//
//  UITableView+Extensions.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit

extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        register(cell.self, forCellReuseIdentifier: cell.identifier)
    }
}
