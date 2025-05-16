//
//  NSLayoutConstraint+Extensions.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/15/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func priority(_ newValue: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = newValue
        return self
    }
}
