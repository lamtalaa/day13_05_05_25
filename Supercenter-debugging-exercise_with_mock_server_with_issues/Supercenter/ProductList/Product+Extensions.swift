//
//  Product+Extensions.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/12/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import Foundation

extension Product {
    var placeholderRating: String? {
        return String(repeating: "★", count: Int(round(Rating.maxRawValue)))
    }

    var formattedAverageRating: String? {
        guard let averageRating = averageRating?.rawValue else {
            return nil
        }

        let filledStars = Int(round(averageRating))
        let maxStars = Int(round(Rating.maxRawValue))

        return String(repeating: "★", count: filledStars) +
            String(repeating: "☆", count: maxStars - filledStars) +
            " " +
            ratingFormatter.string(from: averageRating as NSNumber)!
    }

    var formattedReviewCount: String {
        let format = NSLocalizedString("ProductListProductCellFormattedReviewCount", comment: "")
        return String(format: format, locale: nil, reviewCount ?? 0)
    }

    var formattedPrice: String {
        return priceFormatter.string(from: price as NSNumber)!
    }
}

private let ratingFormatter: NumberFormatter = {
    let ratingFormatter = NumberFormatter()
    ratingFormatter.minimumIntegerDigits = 1
    ratingFormatter.maximumFractionDigits = 1
    ratingFormatter.minimumFractionDigits = 1
    return ratingFormatter
}()

private let priceFormatter: NumberFormatter = {
    let priceFormatter = NumberFormatter()
    priceFormatter.numberStyle = .currency
    priceFormatter.locale = Locale(identifier: "en_US")
    return priceFormatter
}()
