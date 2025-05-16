//
//  Decimal+Extensions.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/12/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

extension Decimal {
    /// Creates a new Decimal from a Double, preserving the given number of (base-10) decimal places.
    ///
    /// Example:
    /// ```
    /// print(Decimal(0.1 + 0.2)) // prints "0.3000000000000000512"
    /// print(Decimal(0.1 + 0.2, precision: 1)) // prints "0.3"
    /// ```
    ///
    /// - Parameter value: The floating point value.
    /// - Parameter precision: The number of decimal places to preserve.
    init(_ value: Double, precision: Int) {
        let multiplier = pow(10, Double(precision))

        self = Decimal(round(value * multiplier)) / Decimal(multiplier)
    }
}
