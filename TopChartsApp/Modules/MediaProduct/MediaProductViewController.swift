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
    func setupLabels()
}

class MediaProductViewController: UIViewController {
    
    
    @IBOutlet var allView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    var presenter: MediaProductPresenterProtocol!
    
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        presenter = MediaProductPresenter(view: self, result: result)
        
        presenter.fetchMediaProduct()
        
        view.backgroundColor = .opaqueSeparator
        
        setupNavigationBar()

        
        setupImageView()
        setBackgroundGradient()
    }
    
    func setupImageView() {
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 15
        logoImageView.clipsToBounds = true
    }
    
    func setupViews() {
        activityIndicator.center = self.view.center
        activityIndicator.isHidden = false
        allView.isHidden = true
    }
    
    
    func setupNavigationBar() {
        title = presenter.getMediaName()
    }
}

extension MediaProductViewController: MediaProductViewControllerProtocol {
    
    func setupLabels() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.artistNameLabel.text = self.presenter.getArtistName()
            self.genresLabel.text = self.presenter.getGenres()
            self.releaseDateLabel.text = self.presenter.getDateRelease()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.allView.isHidden = false
        }
    }
    
    func display(imageData: Data) {
        DispatchQueue.main.async {
            self.logoImageView.image = UIImage(data: imageData)
        }
    }
    
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
