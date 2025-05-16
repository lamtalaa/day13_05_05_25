//
//  RemoteImageView.swift
//  Supercenter
//
//  Created by Alex Johnson on 7/12/19.
//  Copyright © 2019 Supercenter. All rights reserved.
//

import UIKit

class RemoteImageView: UIView {
    private let session: URLSession

    var imageURL: URL? {
        didSet {
            guard oldValue?.absoluteString != imageURL?.absoluteString else {
                return
            }

            deriveImageState()
        }
    }

    private enum ImageState {
        case ready, loading(Cancellable), failed(Error?), succeeded(UIImage)
    }

    private var imageState: ImageState = .ready {
        didSet {
            if case .loading(let task) = oldValue {
                task.cancel()
            }

            applyImageState()
        }
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .placeholderFill
        return imageView
    }()

    init(frame: CGRect = .zero, imageURL: URL? = nil, session: URLSession = .shared) {
        self.session = session
        self.imageURL = imageURL

        super.init(frame: frame)

        addAutoLayoutSubview(imageView)

        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )

        deriveImageState()
        applyImageState()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func deriveImageState() {
        if let url = imageURL {
            let start = Date()

            let task = session.imageTask(with: url) { [weak self] result in
                DispatchQueue.main.async {
                    self?.handle(url: url, duration: -start.timeIntervalSinceNow, result: result)
                }
            }

            task.resume()

            imageState = .loading(task)
        } else {
            imageState = .ready
        }
    }

    private func handle(url: URL, duration: TimeInterval, result: Result<UIImage, Error>) {
        guard url.absoluteString == self.imageURL?.absoluteString else {
            // Ignore response if it's from a request for a different URL (i.e. cell was reused).
            return
        }

        let newImageState: ImageState

        do {
            newImageState = .succeeded(try result.get())
        } catch {
            newImageState = .failed(error)
        }

        // Only animate the change if the request took more than a tiny amount of time:
        let animated = duration > 0.05

        setImageState(newImageState, animated: animated)
    }

    private func setImageState(_ newValue: ImageState, animated: Bool) {
        if animated {
            UIView.transition(with: self,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: { self.imageState = newValue })
        } else {
            imageState = newValue
        }
    }

    private func applyImageState() {
        if case .succeeded(let image) = imageState {
            imageView.image = image
        }
    }
}
