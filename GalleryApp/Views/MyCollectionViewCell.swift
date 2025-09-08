//
//  MyCollectionViewCell.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageView.loadImageUsingCache(url: url)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
}
