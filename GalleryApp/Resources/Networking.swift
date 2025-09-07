//
//  Networking.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//

import Foundation

enum Link {
    case images(page: Int, limit: Int)
    
    var url: URL {
        switch self {
        case .images(let page, let limit):
            return URL(string: "https://api.unsplash.com/photos?page=\(page)&per_page=\(limit)")!
        }
    }
}

final class NetworkManager: ObservableObject {
    
    init() {}
    
    static let shared = NetworkManager()
}
