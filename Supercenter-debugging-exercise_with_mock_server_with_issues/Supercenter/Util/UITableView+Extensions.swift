//
//  UITableView+Extensions.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/15/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

extension UITableView {
    func register<Cell: UITableViewCell>(_ type: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}
