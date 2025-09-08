//
//  ViewController.swift
//  GalleryApp
//
//  Created by MAC on 27.08.25.
//

import UIKit

class ImageGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ImagePresenterDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter = ImagePresenter()
    private var images = [Photo]()
    private var usedId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: "MyCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        presenter.setViewDelegate(delegate: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? MyCollectionViewCell else {
            fatalError("Could not dequeue MyCollectionViewCell")
        }
        let image = images[indexPath.row]
        cell.configure(with: images[indexPath.row].urls.small)
        return cell
    }
    
    func presentImages(images: [Photo]) {
        print("Получено \(images.count) изображений")
        var indexPaths: [IndexPath] = []
        
        for image in images {
            if !usedId.contains(image.id) {
                usedId.append(image.id)
                let index = self.images.count
                self.images.append(image)
                indexPaths.append(IndexPath(item: index, section: 0))
            }
        }
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: indexPaths)
            }, completion: nil)
        }
    }
}
