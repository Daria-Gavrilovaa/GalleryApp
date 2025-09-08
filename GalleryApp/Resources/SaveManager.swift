//
//  SaveManager.swift
//  GalleryApp
//
//  Created by MAC on 08.09.25.
//

import Foundation

final class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let key = "favoritePhotos"
    
    init() {}
    
    func loadFavorites() -> Set<String> {
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            return Set(saved)
        }
        return Set<String>()
    }
    
    func saveFavorites(_ favorites: Set<String>) {
        UserDefaults.standard.set(Array(favorites), forKey: key)
    }
}
