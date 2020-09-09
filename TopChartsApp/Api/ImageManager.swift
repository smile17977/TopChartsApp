//
//  ImageManager.swift
//  TopChartsApp
//
//  Created by Kir Pir on 28.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func getImage(from url: String?) -> Data? {

        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return imageData
    }
}

