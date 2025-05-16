//
//  MockServiceMethod.swift
//  SupercenterTests
//
//  Created by Alex Johnson on 7/16/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation
@testable import Supercenter
import XCTest

class MockServiceMethod<Request, Response> {
    typealias Completion = (Result<Response, Error>) -> Void

    struct MockError: Error {}

    class MockTask: Cancellable {
        fileprivate let request: Request
        fileprivate let completion: Completion
        fileprivate private(set) var isCancelled = false

        init(request: Request, completion: @escaping Completion) {
            self.request = request
            self.completion = completion
        }

        func cancel() {
            isCancelled = true
        }
    }

    private var pending: [MockTask] = []

    var pendingRequests: [Request] {
        return pending.map({ $0.request })
    }

    fileprivate func cancel(_ task: MockTask) {
        pending.removeAll(where: { $0 === task })
    }

    func add(request: Request, completion: @escaping Completion) -> Cancellable {
        let task = MockTask(request: request, completion: completion)
        pending.append(task)
        return task
    }

    func succeed(at index: Int = 0, response: Response) {
        guard pending.indices.contains(index) else {
            XCTFail("Cannot succeed pending request \(index) because pending request count is \(pending.count)")
            return
        }

        let task = pending.remove(at: index)

        if !task.isCancelled {
            task.completion(.success(response))
        }
    }

    func fail(at index: Int = 0, error: Error = MockError()) {
        guard pending.indices.contains(index) else {
            XCTFail("Cannot fail pending request \(index) because pending request count is \(pending.count)")
            return
        }

        let task = pending.remove(at: index)

        if !task.isCancelled {
            task.completion(.failure(error))
        }
    }
}
