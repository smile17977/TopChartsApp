//
//  NetworkManager.swift
//  TopChartsApp
//
//  Created by Kir Pir on 16.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String, with complition: @escaping (MediaProduct) -> Void) {
        
        guard let stringURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: stringURL) { (data, responce, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let mediaProduct = try decoder.decode(MediaProduct.self, from: data)
                complition(mediaProduct)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


