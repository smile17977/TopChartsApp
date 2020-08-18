//
//  mediaProduct.swift
//  TopChartsApp
//
//  Created by Kir Pir on 16.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation

struct MediaProduct: Decodable {
    
    let feed: Feed
}

struct Feed: Decodable {
    
    let results: [Result]
}

struct Result: Decodable {
    
    let artistName: String
    let id: String
    let releaseDate: String
    let name: String
    let kind: String
    let copyright: String
    let artworkUrl100: String?
    let genres: [Genre]
}

struct Genre: Decodable {
    
    let name: String    
}


