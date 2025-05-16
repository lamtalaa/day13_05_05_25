//
//  Environment.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/10/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

enum Environment {
    case local
    case imageUrl
    static let current: Environment = .local
}

extension Environment {
    var supercenterAPIBaseURL: URL {
        switch self {
        case .local:
            return URL(string: "http://localhost:3000/api/")!
        case .imageUrl:
            return URL(string: "http://localhost:3000/")!
        }
    }
}
