//
//  ImageDetailViewController.swift
//  GalleryApp
//
//  Created by MAC on 08.09.25.
//

import UIKit

class ImageDetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var desctiptionText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    weak var galleryVC: ImageGalleryViewController?
    
    var selectedImageIndex = 0
    var images: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInfo()
    }
    
    func showInfo() {
        guard selectedImageIndex >= 0, selectedImageIndex < images.count else { return }
        let selectedImage = images[selectedImageIndex]
        
        guard let url = URL(string: selectedImage.urls.full) else { return }
        
        imageView.loadImageUsingCache(url: url) { [weak self] in
            guard let self = self else { return }
            
            let title = selectedImage.user.username ?? ""
            let description = selectedImage.description ?? ""
            self.desctiptionText.text = "\(description)"
            self.username.text = "Username:\(title)"
            if let galleryVC = self.galleryVC {
                let isFav = galleryVC.favoriteId.contains(selectedImage.id)
                let imageName = isFav ? "heart.fill" : "heart"
                self.heartButton.setImage(UIImage(systemName: imageName), for: .normal)
            }
        }
    }
    
    
    @IBAction func leftSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        if selectedImageIndex + 1 < images.count {
            selectedImageIndex += 1
            showInfo()
        }
    }
    
    @IBAction func rightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        if selectedImageIndex - 1 >= 0 {
            selectedImageIndex -= 1
            showInfo()
        }
    }
    
    
    @IBAction func addFavorite(_ sender: UIButton) {
        if selectedImageIndex >= 0 && selectedImageIndex < images.count {
            let selectedImage = images[selectedImageIndex]
            guard let galleryVC else {return}
            
            if galleryVC.favoriteId.contains(selectedImage.id)  {
                galleryVC.favoriteId.remove(selectedImage.id)
                heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                galleryVC.favoriteId.insert(selectedImage.id)
                heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            
            FavoritesManager.shared.saveFavorites(galleryVC.favoriteId)
            
            showInfo()
            let indexPath = IndexPath(item: selectedImageIndex, section: 0)
            galleryVC.collectionView.reloadItems(at: [indexPath])
        }
    }
}
