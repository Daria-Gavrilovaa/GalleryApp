//
//  CacheManager.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//

import UIKit

extension UIImageView {
    private static let imageCache = NSCache<NSURL, UIImage>()

    func loadImageUsingCache(url: URL, completion: (() -> Void)? = nil) {
        if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            completion?()
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            UIImageView.imageCache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                self.image = image
                completion?() 
            }
        }.resume()
    }
}
