//
//  ProductTests.swift
//  SupercenterTests
//
//  Created by Alex Johnson on 7/12/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

@testable import Supercenter
import XCTest

class ProductTests: XCTestCase {
    func testPlaceholderRating() {
        let product = Product(id: "1")

        XCTAssertEqual(product?.placeholderRating, "★★★★★")
    }

    func testNoRating() {
        let product = Product(id: "1", averageRating: nil)

        XCTAssertEqual(product?.formattedAverageRating, nil)
    }
}
