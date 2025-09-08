//
//  CacheManager.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//

import UIKit

enum ImageError: Error {
    case invalidStatus
    case noData
    case tooManyRequests
}

extension UIImageView {
    private static let imageCache = NSCache<NSURL, UIImage>()

    func loadImageUsingCache(url: URL, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
        if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            completion(.success(cachedImage))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.noData))
                return
            }
            
            let httpsResponse = response as? HTTPURLResponse
            print("Status code: \(String(describing: httpsResponse?.statusCode))")
            
            if httpsResponse?.statusCode == 429 {
                completion(.failure(.tooManyRequests))
            }
                
            UIImageView.imageCache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                self.image = image
                completion(.success(image))
            }
        }.resume()
    }
}
