//
//  MediaProductViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 18.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

class MediaProductViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    var result: Result!
    var genres: [Genre]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .opaqueSeparator
        
        setupNavigationBar()
        
        setupLabels()
        
        setupImageView()
        fetchImage()
        
    }
    
    func setupImageView() {
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 15
        logoImageView.clipsToBounds = true
    }
    
    func setupLabels() {
        artistNameLabel.text = "* Developer: \(result.artistName)"
        
        genres = result.genres
        let separatedGenres = genres.compactMap({ (Genre) -> String in
            Genre.name
        })
        genresLabel.text = "* Genres: \(separatedGenres.joined(separator: ", "))"
        releaseDateLabel.text = "* Date of release: \(result.releaseDate)"
        
    }
    
    func fetchImage() {
        guard let stringURL = result.artworkUrl100 else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        
        DispatchQueue.main.async {
            self.logoImageView.image = UIImage(data: imageData)
            
        }
    }
    
    func setupNavigationBar() {
               title = result.name
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
