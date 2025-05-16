//
//  ProductListProductCell.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/11/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

/// Alpha value for views when the product is out of stock.
private let outOfStockAlpha: CGFloat = 0.4

class ProductListProductCell: UITableViewCell {
    private let productImageView = RemoteImageView()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .title3)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()

    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .preferredFont(forTextStyle: .caption1)
        return ratingLabel
    }()

    private let reviewCountLabel: UILabel = {
        let reviewCountLabel = UILabel()
        reviewCountLabel.font = .preferredFont(forTextStyle: .caption2)
        reviewCountLabel.textColor = .gray
        return reviewCountLabel
    }()

    private let priceLabel: UILabel = {
        let reviewCountLabel = UILabel()
        reviewCountLabel.font = .preferredFont(forTextStyle: .headline)
        return reviewCountLabel
    }()

    private let outOfStockLabel: UILabel = {
        let outOfStockLabel = UILabel()
        outOfStockLabel.font = .preferredFont(forTextStyle: .caption2)
        outOfStockLabel.textColor = .red
        outOfStockLabel.text = NSLocalizedString("ProductListProductCellOutOfStock", comment: "")
        return outOfStockLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let detailsColumnGuide = UILayoutGuide()

        contentView.addLayoutGuide(detailsColumnGuide)

        contentView.addAutoLayoutSubview(productImageView)
        contentView.addAutoLayoutSubview(nameLabel)
        contentView.addAutoLayoutSubview(ratingLabel)
        contentView.addAutoLayoutSubview(reviewCountLabel)
        contentView.addAutoLayoutSubview(priceLabel)
        contentView.addAutoLayoutSubview(outOfStockLabel)

        NSLayoutConstraint.activate(
            [
                productImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
                productImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
                productImageView.widthAnchor.constraint(equalToConstant: 80),
                productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor, multiplier: 1, constant: 0),
                productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor).priority(.defaultHigh),

                detailsColumnGuide.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
                detailsColumnGuide.leadingAnchor.constraint(equalToSystemSpacingAfter: productImageView.trailingAnchor, multiplier: 1),
                detailsColumnGuide.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
                detailsColumnGuide.bottomAnchor.constraint(lessThanOrEqualTo: contentView.readableContentGuide.bottomAnchor).priority(.defaultHigh),

                nameLabel.topAnchor.constraint(equalTo: detailsColumnGuide.topAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: detailsColumnGuide.leadingAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: detailsColumnGuide.trailingAnchor),

                ratingLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),

                ratingLabel.leadingAnchor.constraint(equalTo: detailsColumnGuide.leadingAnchor),
                ratingLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailsColumnGuide.trailingAnchor),

                reviewCountLabel.firstBaselineAnchor.constraint(equalTo: ratingLabel.firstBaselineAnchor),
                reviewCountLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: ratingLabel.trailingAnchor, multiplier: 1),
                reviewCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailsColumnGuide.trailingAnchor),

                priceLabel.topAnchor.constraint(equalToSystemSpacingBelow: ratingLabel.bottomAnchor, multiplier: 1),

                priceLabel.leadingAnchor.constraint(equalTo: detailsColumnGuide.leadingAnchor),
                priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailsColumnGuide.trailingAnchor),
                priceLabel.bottomAnchor.constraint(equalTo: detailsColumnGuide.bottomAnchor),

                outOfStockLabel.firstBaselineAnchor.constraint(equalTo: priceLabel.firstBaselineAnchor),
                outOfStockLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: priceLabel.trailingAnchor, multiplier: 1),
                outOfStockLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailsColumnGuide.trailingAnchor)
            ]
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(product: Product?) {
        productImageView.imageURL = product?.imageURL

        nameLabel.text = product?.name

        if let formattedAverageRating = product?.formattedAverageRating {
            ratingLabel.text = formattedAverageRating
            ratingLabel.textColor = .black
        } else {
            ratingLabel.text = product?.placeholderRating
            ratingLabel.textColor = .placeholderFill
        }

        reviewCountLabel.text = product?.formattedReviewCount
        priceLabel.text = product?.formattedPrice

        if  false {
            productImageView.alpha = 1
            nameLabel.alpha = 1
            priceLabel.alpha = 1
            ratingLabel.alpha = 1
            outOfStockLabel.isHidden = true
        } else {
            productImageView.alpha = outOfStockAlpha
            nameLabel.alpha = outOfStockAlpha
            priceLabel.alpha = outOfStockAlpha
            ratingLabel.alpha = outOfStockAlpha
            outOfStockLabel.isHidden = false
        }
    }
}
