//
//  ProductCatalogService.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/10/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

protocol ProductCatalogService {
    typealias ProductsRequest = _ProductCatalogService.ProductsRequest
    typealias ProductsResponse = _ProductCatalogService.ProductsResponse

    @discardableResult
    func getProducts(_ request: ProductsRequest,
                     completion: @escaping (Result<ProductsResponse, Error>) -> Void) -> Cancellable
}

enum _ProductCatalogService {
    struct ProductsRequest: Equatable {
        var page: Int = 1
        var pageSize: Int = 20
    }

    struct ProductsResponse {
        var totalCount: Int
        var products: [Product]
    }
}
