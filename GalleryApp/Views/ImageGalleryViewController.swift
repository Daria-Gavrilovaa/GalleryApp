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
    }
}
