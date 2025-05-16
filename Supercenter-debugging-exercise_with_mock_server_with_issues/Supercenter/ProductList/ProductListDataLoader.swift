//
//  ProductListDataLoader.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/11/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

class ProductListDataLoader {
    
    private let service: ProductCatalogService

    private(set) var data: ProductListData {
        didSet {
            self.onChange?(oldValue, self.data)           
        }
    }

    private var currentRequest: (request: ProductCatalogService.ProductsRequest, task: Cancellable)?

    var onChange: ((_ oldData: ProductListData, _ newData: ProductListData) -> Void)?
    
    var onError: ((Error) -> Void)?

    init(pageSize: Int, service: ProductCatalogService) {
        self.data = ProductListData(pageSize: pageSize)
        self.service = service
    }

    var isLoadingMore: Bool {
        return currentRequest != nil
    }

    func loadMore() {
        guard data.canLoadMore && !isLoadingMore else {
            return
        }

        let request = data.nextRequest
        let task = service.getProducts(request) { [weak self] in self?.handle(request: request, result: $0) }

        currentRequest = (request: request, task: task)
    }

    private func handle(request: ProductCatalogService.ProductsRequest,
                        result: Result<ProductCatalogService.ProductsResponse, Error>)
    {
        assert(currentRequest?.request == request)

        currentRequest = nil

        do {
            data.recordSuccess(page: try result.get())
        } catch {
            print(error)
            data.recordFailure(error: error)
                self.onError?(error)
        }
    }
}
