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
    
}
