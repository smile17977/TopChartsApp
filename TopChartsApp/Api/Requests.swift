//
//  Requests.swift
//  TopChartsApp
//
//  Created by Kir Pir on 16.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation

struct Requests {
    
    static let shared = Requests()
    
    private init() {}

    func configureURL(country: String, channel: String, carrier: String, quantity: String) -> String {
        let mediaProductURL = "https://rss.itunes.apple.com/api/v1/\(country)/\(carrier)/\(channel)/all/\(quantity)/explicit.json"
        return mediaProductURL
    }
}
