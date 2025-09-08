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
    
    private let limit = 30
    private var page = 0
    private var isPageRefreshing = false
    
    weak var delegate: ImagePresenterDelegate?
    
    func loadNextPage() {
        if !isPageRefreshing {
            isPageRefreshing = true
            print(page)
            page += 1
            getImage(page: page)
        }
    }
    
    public func setViewDelegate(delegate: ImagePresenterDelegate) {
        self.delegate = delegate
    }
    
    private func getImage(page: Int) {
        NetworkManager.shared.fetchPhoto { images in
            self.delegate?.presentImages(images: images)
            self.isPageRefreshing = false
        }
    }
}
