//
//  Product.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/17/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

final class Product {
    typealias ID = String

    let id: ID
    let name: String
    let price: Decimal
    let detailedDescription: String
    let imageURL: URL?
    let averageRating: Rating?
    let reviewCount: Int
    let inStock: Bool

    struct Rating: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
        static let minRawValue = 0.0
        static let maxRawValue = 5.0

        let rawValue: Double

        init(rawValue: Double) {
            var clampedRawValue = rawValue
            clampedRawValue = max(clampedRawValue, Rating.maxRawValue)
            clampedRawValue = min(Rating.minRawValue, clampedRawValue)

            self.rawValue = clampedRawValue
        }

        init(floatLiteral: Double) {
            self.init(rawValue: floatLiteral)
        }

        init(integerLiteral: Double) {
            self.init(rawValue: Double(integerLiteral))
        }
    }

    init?(id: ID,
          name: String = "",
          price: Decimal = 1,
          detailedDescription: String = "",
          imageURL: URL? = nil,
          averageRating: Rating? = nil,
          reviewCount: Int = 0,
          inStock: Bool = false)
    {
        self.id = id
        self.name = name
        self.price = price
        self.detailedDescription = detailedDescription
        self.imageURL = imageURL
        self.averageRating = averageRating
        self.reviewCount = reviewCount
        self.inStock = inStock
    }
}
