//
//  UIImageView+Extension.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import Foundation
import UIKit
import SDWebImage
import Combine

extension UIImageView {
    func downloadImage(with url: String, placeHolder: String? = nil) {
        var placeHolderImage: UIImage?
        if let unwrappedPlaceHolder = placeHolder { placeHolderImage = UIImage(named: unwrappedPlaceHolder) }
        guard let imageURL = URL(string: url) else {
            self.image = placeHolderImage
            return
        }
        configureLoadingIndicator()
        sd_setImage(with: imageURL, placeholderImage: placeHolderImage) { [weak self] image, _, _, _ in
            if let _ = image {
                self?.stopLoadingAnimation()
            }
        }
        if let _ = image {
            stopLoadingAnimation()
        }
    }
    
    private func cancelDownload() {
        sd_cancelCurrentImageLoad()
        stopLoadingAnimation()
    }
    
    private func stopLoadingAnimation() {
        guard let view = self.subviews.first as? UIActivityIndicatorView else { return }
        view.stopAnimating()
    }
    
    private func configureLoadingIndicator() {
        if let view = self.subviews.first as? UIActivityIndicatorView {
            view.startAnimating()
            return
        }
        addActivityIndicatorToCenter().startAnimating()
    }
    
    private func addActivityIndicatorToCenter() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.addSubview(activityIndicator)
        self.bringSubviewToFront(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0)
        ])
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }
}
