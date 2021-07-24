//
//  Extension.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

extension UIView {
    func setupCornerRadius() {
        layer.cornerRadius = 8.0
        clipsToBounds = true
    }
}

extension UIImageView {
    func downloadImageFromURL(_ url: URL?, with placeholderImage: UIImage? = nil) -> URLSessionTask? {
        DispatchQueue.main.async {
            self.image = placeholderImage
        }
        
        guard let url = url else {
            return nil
        }
        
        return ImageDownloader.download(from: url) { [weak self] (downloadedImage, httpError) in
            guard let self = self, httpError == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }
    }
}
