//
//  MediaProductTableViewCell.swift
//  TopChartsApp
//
//  Created by Kir Pir on 18.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

class MediaProductTableViewCell: UITableViewCell {
    @IBOutlet var imageOfMedia: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    func configure(_ imageView: UIImageView) {
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 4
        imageView.clipsToBounds = true
    }
    
    func configure(with results: [Result]?, for index: Int, cell: MediaProductTableViewCell?) {
           
           
           cell?.nameLabel?.text = results?[index].name
           DispatchQueue.global().async {
           guard let stringURL = results?[index].artworkUrl100 else { return }
           guard let imageURL = URL(string: stringURL) else { return }
           guard let imageData = try? Data(contentsOf: imageURL) else { return }
           
           DispatchQueue.main.async {
               cell?.imageOfMedia?.image = UIImage(data: imageData)
               
           }
        }
       }

}