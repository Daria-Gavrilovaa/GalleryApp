//
//  MyCollectionViewCell.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        bringSubviewToFront(heartImage)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        heartImage.isHidden = true
    }
    
    public func configure(with urlString: String, favoriteImage: Bool) {
        guard let url = URL(string: urlString) else { return }
        imageView.loadImageUsingCache(url: url) { result in
            switch result {
            case .success(_):
                print("Загружено")
            case .failure(let error):
                print("Ошибка загрузки: \(error)")
            }
        }
        heartImage.isHidden = !favoriteImage
        heartImage.image = UIImage(systemName: "heart.fill")
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
}
