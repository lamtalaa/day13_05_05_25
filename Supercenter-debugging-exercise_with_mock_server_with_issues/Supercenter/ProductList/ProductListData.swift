//
//  ProductListData.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/15/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

struct ProductListData {
    let pageSize: Int

    private(set) var products: [Product] = []
    private var totalCount = 1 // assume at least one result until we receive the first response

    private var loadedPageCount = 0
    private(set) var hasRecordedFailure = false

    init(pageSize: Int) {
        self.pageSize = pageSize
    }

    var nextRequest: ProductCatalogService.ProductsRequest {
        return .init(page: loadedPageCount + 1, pageSize: pageSize)
    }

    mutating func recordSuccess(page response: ProductCatalogService.ProductsResponse) {
        products.append(contentsOf: response.products)
        totalCount = response.totalCount
        loadedPageCount += 1
    }

    mutating func recordFailure(error: Error) {
        hasRecordedFailure = true
    }

    // Bug 6: add condition loadedPageCount <= totalCount / pageSize
    var canLoadMore: Bool {
        return !hasRecordedFailure && products.count < totalCount && loadedPageCount <= totalCount / pageSize
    }

    func product(at index: Int) -> Product? {
        guard products.indices.contains(index) else {
            return nil
        }

        return products[index]
    }
}
