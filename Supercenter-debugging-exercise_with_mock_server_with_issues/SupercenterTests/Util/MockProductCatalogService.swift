//
//  MockProductCatalogService.swift
//  SupercenterTests
//
//  Created by Alex Johnson on 7/16/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation
@testable import Supercenter
import XCTest

/// A mock implementation of the `ProductCatalogService` protocol.
///
/// The goal of this implementation is to support synchronous testing, while still having the `completion` handler
/// executed _after_ `getProducts()` has returned.
///
/// See `getProducts()` for a usage example
class MockProductCatalogService: ProductCatalogService {
    let getProductsMethod = MockServiceMethod<ProductsRequest, ProductsResponse>()

    /// A mock implementation of the `ProductCatalogService.getProducts()` method.
    ///
    /// When `getProducts()` is called, the completion handler is added to `getProductsMethod`'s list of pending
    /// requests. Afterward, invoking `getProdcutsMethod.succeed()` or `.fail()` will invoke that completion handler.
    ///
    /// Example usage:
    /// ```
    /// let mockService = MockProductCatalogService()
    /// var totalCount: Int?
    ///
    /// mockService.getProducts() { result in
    ///     totalCount = try? result.get().totalCount
    /// }
    ///
    /// // Request is still pending:
    /// XCTAssertNil(totalCount)
    ///
    /// mockService.getProductsMethod
    ///     .succeed(response: .init(totalCount: 1, products: []))
    ///
    /// // Request has completed:
    /// XCTAssertEqual(totalCount, 1)
    /// ```
    @discardableResult
    func getProducts(_ request: ProductsRequest, completion: @escaping (Result<ProductsResponse, Error>) -> Void) -> Cancellable {
        return getProductsMethod.add(request: request, completion: completion)
    }
}
