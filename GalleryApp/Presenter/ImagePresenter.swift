//
//  ImagePresenter.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//

import Foundation

protocol ImagePresenterDelegate: AnyObject {
    func presentImages(images: [Photo])
}

class ImagePresenter {
    
    weak var delegate: ImagePresenterDelegate?
    
    public func setViewDelegate(delegate: ImagePresenterDelegate) {
        self.delegate = delegate
    }
    
    private func getImage() {
        NetworkManager.shared.fetchPhoto { images in
            <#code#>
        }
    }
}
