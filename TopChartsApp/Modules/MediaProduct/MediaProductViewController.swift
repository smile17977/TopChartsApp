//
//  MediaProductViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 18.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol MediaProductViewControllerProtocol: class {
    
    func display(imageData: Data)
    func setupLabel(for label: UILabel, with info: String)
    func setupImageView()
    func setupNavigationBar(name: String)
    func displayImage(for image: UIImage)
}

class MediaProductViewController: UIViewController {
    
    @IBOutlet var allView: UIView!
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    var presenter: MediaProductPresenterProtocol!
    
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MediaProductPresenter(view: self, result: result)
        
        presenter.getImage()
        
        setupLabel(for: artistNameLabel, with: presenter.getArtistName())
        setupLabel(for: genresLabel, with: presenter.getGenres())
        setupLabel(for: releaseDateLabel, with: presenter.getDateRelease())

        setupNavigationBar(name: presenter.getMediaName())
        view.setGradientBackground(colorOne: Colors.darkGreen,
                                   colorTwo: Colors.lightGreen)
    }
}

extension MediaProductViewController: MediaProductViewControllerProtocol {
    
    func setupLabel(for label: UILabel, with info: String) {
        label.text = info
        label.font = UIFont(name: "AppleSDGothicNeo-Regular",
                            size: 20)
        label.backgroundColor = UIColor(red: 76.0/255.0,
                                        green: 125.0/255.0,
                                        blue: 50.0/255.0,
                                        alpha: 0.5)
        label.clipsToBounds = true
        label.layer.cornerRadius = 7
    }
    
    func setupImageView() {
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 15
        logoImageView.clipsToBounds = true
    }
    
    func setupNavigationBar(name: String) {
        title = name
    }
    
    func display(imageData: Data) {
        logoImageView.image = UIImage(data: imageData)
    }
    
    func displayImage(for image: UIImage) {
        logoImageView.image = image
    }
}
