//
//  MediaProductPresenter.swift
//  TopChartsApp
//
//  Created by Kir Pir on 26.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation

protocol MediaProductPresenterProtocol {
    init(view: MediaProductViewControllerProtocol, result: Result)
    
    func fetchImage()
    func getMediaName() -> String
    func getGenres() -> String
    func getArtistName() -> String
    func getDateRelease() -> String
}

class MediaProductPresenter: MediaProductPresenterProtocol {
    
    var result: Result
    
    private unowned let view: MediaProductViewControllerProtocol!
    
    required init(view: MediaProductViewControllerProtocol, result: Result) {
        self.view = view
        self.result = result
    }
    
    func fetchImage() {
        guard let stringURL = result.artworkUrl100 else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        
        DispatchQueue.main.async {
            self.view.startActivityIndicator()
            self.view.display(imageData: imageData)
            self.view.stopActivityIndicator()
        }
    }
    
    func getMediaName() -> String {
        return result.name
    }
    
    func getGenres() -> String {
        let separatedGenres = result.genres.compactMap({ (Genre) -> String in
            Genre.name
        })
        return "* Genres: \(separatedGenres.joined(separator: ", "))"
    }
    
    func getArtistName() -> String {
        "* Developer: \(result.artistName)"
    }
    
    func getDateRelease() -> String {
        "* Date of release: \(result.releaseDate)"
    }
}
