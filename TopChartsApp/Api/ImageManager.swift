//
//  ImageManager.swift
//  TopChartsApp
//
//  Created by Kir Pir on 28.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func fetchImage(stringURL: String, completion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: stringURL) else { return }
        
        if let cachedImage = imageCache.object(forKey:url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, responce, error) in
                
                if let error = error { print(error) }
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}

