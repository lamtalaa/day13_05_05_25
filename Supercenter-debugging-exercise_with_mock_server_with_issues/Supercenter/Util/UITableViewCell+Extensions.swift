//
//  UITableViewCell+Extensions.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/15/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
