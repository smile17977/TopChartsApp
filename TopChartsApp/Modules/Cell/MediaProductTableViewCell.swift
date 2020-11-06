//
//  MediaProductTableViewCell.swift
//  TopChartsApp
//
//  Created by Kir Pir on 18.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol MediaProductTableViewCellProtocol {
    
    func cellColor(color: UIColor)
    func setImage(for image: UIImage)
    func setDefaultImage()
    func setLabel(name: String)
}

class MediaProductTableViewCell: UITableViewCell {
    
    @IBOutlet var imageOfMedia: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MediaProductTableViewCell: MediaProductTableViewCellProtocol {
    
    func cellColor(color: UIColor) {
        backgroundColor = color
    }
    
    func setLabel(name: String) {
        nameLabel.text = name
        nameLabel.font = UIFont(
        name: "AppleSDGothicNeo-Regular",
        size: 20)
    }
    
    func setDefaultImage() {
        imageOfMedia.image = #imageLiteral(resourceName: "picture")
    }
    
    func setImage(for image: UIImage) {
        imageOfMedia.image = image
        imageOfMedia.layer.cornerRadius = imageOfMedia.frame.size.height / 6
        imageOfMedia.clipsToBounds = true
    }
}
