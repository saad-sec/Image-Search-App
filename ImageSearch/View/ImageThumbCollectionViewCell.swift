//
//  ImageThumbCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

class ImageThumbCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeHolderImageView: UIImageView!
    
    static let nibName = "ImageThumbCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
        imageView.image = nil
    }
    
    var model: ImageModel? {
        didSet {
            if let model = model {
                placeHolderImageView.image = UIImage(named: "Hourglass")
                imageView.downloadImage(model.imageURL)
            }
        }
    }
}
