//
//  ProductListViewController.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/10/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController {
    private let dataLoader: ProductListDataLoader
    
    init(pageSize: Int = 5, service: ProductCatalogService = SupercenterAPIClient.shared) {
        self.dataLoader = ProductListDataLoader(pageSize: pageSize, service: service)

        super.init(nibName: nil, bundle: nil)

        dataLoader.onChange = { [weak self] in
            
            self?.handleDataLoaderChange(from: $0, to: $1)
            
        }
        dataLoader.onError = { [weak self] in self?.handleDataLoaderFailure(error: $0) }

        title = NSLocalizedString("ProductListTitle", comment: "")

        tableView.register(ProductListLoadingCell.self)
        tableView.register(ProductListProductCell.self)
        tableView.register(ProductListErrorCell.self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dataLoader.loadMore()
    }

    // MARK: - Table View

    private enum Section: Int, CaseIterable {
        case products, errors, loading
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .products:
            return dataLoader.data.products.count

        case .errors:
            return dataLoader.data.hasRecordedFailure ? 1 : 0

        case .loading:
            return (dataLoader.isLoadingMore || dataLoader.data.canLoadMore) ? 1 : 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .products:
                let cell: ProductListProductCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(product: dataLoader.data.product(at: indexPath.row))
                return cell

        case .errors:
            return tableView.dequeueReusableCell(for: indexPath) as ProductListErrorCell

        case .loading:
            return tableView.dequeueReusableCell(for: indexPath) as ProductListLoadingCell
        }
    }

    private func handleDataLoaderChange(from oldValue: ProductListData, to newValue: ProductListData) {
        // Bug 1:  put UI related code to main thread
        DispatchQueue.main.async {
            self.tableView.performBatchUpdates(
                {
                    let insertIndexPaths: [IndexPath] = (oldValue.products.count ..< newValue.products.count).map {
                        IndexPath(row: $0, section: Section.products.rawValue)
                    }
                    
                    self.tableView.insertRows(at: insertIndexPaths, with: .automatic)
                    
                    self.tableView.reloadSections([Section.loading.rawValue, Section.errors.rawValue], with: .automatic)
                },
                completion: { [weak self] _ in
                    self?.checkContinueLoading()
                }
            )
        }
    }

    private func handleDataLoaderFailure(error: Error) {
        let title: String, message: String

        switch (error as? SupercenterAPIClient.ResponseError) ?? .unknown {
        case .noProducts:
            title = NSLocalizedString("ProductListEmptyTitle", comment: "")
            message = NSLocalizedString("ProductListEmptyMessage", comment: "")

        case .unableToConnect:
            title = NSLocalizedString("ProductListConnectionFailureTitle", comment: "")
            message = NSLocalizedString("ProductListConnectionFailureMessage", comment: "")

        case .badResponseStatusCode, .unknown:
            title = NSLocalizedString("ProductListLoadFailureTitle", comment: "")
            message = NSLocalizedString("ProductListLoadFailureMessage", comment: "")
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default)

        alert.addAction(action)
        alert.preferredAction = action

        // Bug 2: put UI related code to main thread
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }

    private func checkContinueLoading() {
        // Continue loading pages of products as long as the "loading" cell is being displayed.

        if tableView.indexPathsForVisibleRows?.contains(where: { Section(rawValue: $0.section)! == .loading }) ?? false {
            dataLoader.loadMore()
        }
    }

    // Scroll View

    override func scrollViewDidEndDecelerating(_: UIScrollView) {
        checkContinueLoading()
    }
}
