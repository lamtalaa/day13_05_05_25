//
//  UIView+Extensions.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/11/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

extension UIView {
    func addAutoLayoutSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}
