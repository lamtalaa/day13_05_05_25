//
//  ProductListLoadingCell.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/11/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

class ProductListLoadingCell: UITableViewCell {
    private let spinner = UIActivityIndicatorView(style: .gray)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addAutoLayoutSubview(spinner)

        NSLayoutConstraint.activate(
            [
                contentView.layoutMarginsGuide.topAnchor.constraint(equalTo: spinner.topAnchor),
                contentView.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
                contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: spinner.bottomAnchor)
            ]
        )

        spinner.startAnimating()
        spinner.hidesWhenStopped = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        spinner.startAnimating()
    }
}
