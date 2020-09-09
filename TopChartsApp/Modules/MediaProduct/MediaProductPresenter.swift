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
    
    func fetchMediaProduct()
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
    
    func fetchMediaProduct() {
        self.view.startActivityIndicator()
        DispatchQueue.global().async{
            guard let imageData = ImageManager.shared.getImage(from: self.result.artworkUrl100) else { return }
            
            self.view.display(imageData: imageData)
            self.view.setupLabels()
        }
        
    }
    
    func getMediaName() -> String {
        return result.name ?? ""
    }
    
    func getGenres() -> String {
        let separatedGenres = result.genres.compactMap({ (Genre) -> String in
            Genre.name
        })
        return "* Genres: \(separatedGenres.joined(separator: ", "))"
    }
    
    func getArtistName() -> String {
        "* Developer: \(result.artistName ?? "")"
    }
    
    func getDateRelease() -> String {
        "* Date of release: \(result.releaseDate ?? "")"
    }
}
