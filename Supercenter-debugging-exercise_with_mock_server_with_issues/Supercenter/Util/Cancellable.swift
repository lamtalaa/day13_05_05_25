//
//  Cancellable.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/11/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {
}
