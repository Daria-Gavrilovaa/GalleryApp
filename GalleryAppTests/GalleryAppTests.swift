//
//  GalleryAppTests.swift
//  GalleryAppTests
//
//  Created by MAC on 27.08.25.
//

import XCTest
@testable import GalleryApp

final class GalleryAppTests: XCTestCase {
    
    func testFetchPhotosSuccess() {
        let expectation = self.expectation(description: "Fetching photos succeeds")
        
        NetworkManager.shared.fetchPhoto(page: 1, limit: 5) { result in
            switch result {
            case .success(let photos):
                XCTAssertFalse(photos.isEmpty, "Фото не должны пустовать")
                XCTAssertEqual(photos.count, 5, "Должно быть по крайней мере 5 фото")
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testFetchPhotosInvalidPage() {
        let expectation = self.expectation(description: "Fetching photos with invalid page")
        
        NetworkManager.shared.fetchPhoto(page: -1, limit: 5) { result in
            switch result {
            case .success(let photos):
                XCTAssertNotNil(photos, "Массив должен возвращаться вне зависимости от того, пуст ли он")
            case .failure(let error):
                XCTAssertTrue(error == .noData || error == .decodingError)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    
    func testSaveAndLoadFavorites() {
        let manager = FavoritesManager.shared
        let sampleFavorites: Set<String> = ["id1", "id2", "id3"]
        
        manager.saveFavorites(sampleFavorites)
        let loadedFavorites = manager.loadFavorites()
        
        XCTAssertEqual(sampleFavorites, loadedFavorites, "Загруженные избранные фото должны соответствовать понравившимся")
    }
    
    func testImageCaching() {
        let imageView = UIImageView()
        
        guard let imagePath = Bundle(for: type(of: self)).path(forResource: "test", ofType: "jpg"),
              let imageUrl = URL(string: "file://\(imagePath)") else {
            XCTFail("Не удалось найти локальный файл изображения")
            return
        }
        
        let expectation = self.expectation(description: "Image should be loaded and cached")
        
        imageView.loadImageUsingCache(url: imageUrl) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image, "Изображение должно быть успешно загружено")
                
                imageView.loadImageUsingCache(url: imageUrl) { cachedResult in
                    switch cachedResult {
                    case .success(let cachedImage):
                        XCTAssertNotNil(cachedImage, "Кэшированные изображения должны быть доступны")
                        expectation.fulfill()
                    case .failure:
                        XCTFail("Кэшированные изображения не должны терпеть крах")
                    }
                }
            case .failure(let error):
                XCTFail("\(error)")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
}

