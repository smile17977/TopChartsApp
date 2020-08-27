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
    func startActivityIndicator()
    func stopActivityIndicator()
}

class MediaProductViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    var presenter: MediaProductPresenterProtocol!
    
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MediaProductPresenter(view: self, result: result)
        
        presenter.fetchImage()
        
        view.backgroundColor = .opaqueSeparator
        
        setupNavigationBar()
        setupLabels()
        setupImageView()
    }
    
    func setupImageView() {
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 15
        logoImageView.clipsToBounds = true
    }
    
    func setupLabels() {
        artistNameLabel.text = presenter.getArtistName()
        genresLabel.text = presenter.getGenres()
        releaseDateLabel.text = presenter.getDateRelease()
    }
    
    func setupNavigationBar() {
        title = presenter.getMediaName()
    }
}

extension MediaProductViewController: MediaProductViewControllerProtocol {
    
    func display(imageData: Data) {
        DispatchQueue.main.async {
            self.logoImageView.image = UIImage(data: imageData)
        }
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
