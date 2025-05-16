//
//  ProductListErrorCell.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/12/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

class ProductListErrorCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = NSLocalizedString("ProductListErrorCellMessage", comment: "")

        contentView.addAutoLayoutSubview(label)

        NSLayoutConstraint.activate(
            [
                contentView.layoutMarginsGuide.topAnchor.constraint(equalTo: label.topAnchor),
                contentView.layoutMarginsGuide.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: label.trailingAnchor),
                contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor)
            ]
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
