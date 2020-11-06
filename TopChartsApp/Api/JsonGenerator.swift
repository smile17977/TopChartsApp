//
//  JsonGenerator.swift
//  TopChartsApp
//
//  Created by Kir Pir on 01.09.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation

struct Carrier {
    var name: String
    var code: String
}

struct Channel {
    var name: String
    var code: String
    var typeOfCarrier: String
}

struct Country {
    var name: String
    var code: String
}

struct Quantity {
    var name: String
}

class JsonGenerator {
    
    var carriers = [Carrier]()
    var channels = [Channel]()
    var countries = [Country]()
    var quantities = [Quantity]()
    
    init() {
        setupData()
    }
    
    private func setupData() {
        
        let carrier1 = Carrier(name: "Apple music",
                               code: "apple-music")
        let carrier2 = Carrier(name: "Apple store",
                               code: "ios-apps")
        let carrier3 = Carrier(name: "Books",
                               code: "books")
        let carrier4 = Carrier(name: "Movies",
                               code: "movies")
        
        carriers.append(carrier1)
        carriers.append(carrier2)
        carriers.append(carrier3)
        carriers.append(carrier4)
        
        let channel1 = Channel(name: "Coming Soon",
                               code: "coming-soon",
                               typeOfCarrier: "Apple music")
        let channel2 = Channel(name: "Hot Tracks",
                               code: "hot-tracks",
                               typeOfCarrier: "Apple music")
        let channel3 = Channel(name: "Top Free",
                               code: "top-free",
                               typeOfCarrier: "Apple store")
        let channel4 = Channel(name: "Top Paid",
                               code: "top-paid",
                               typeOfCarrier: "Apple store")
        let channel5 = Channel(name: "Top Free",
                               code: "top-free",
                               typeOfCarrier: "Books")
        let channel6 = Channel(name: "Top Paid",
                               code: "top-paid",
                               typeOfCarrier: "Books")
        let channel7 = Channel(name: "Top Movies",
                               code: "top-movies",
                               typeOfCarrier: "Movies")
        
        channels.append(channel1)
        channels.append(channel2)
        channels.append(channel3)
        channels.append(channel4)
        channels.append(channel5)
        channels.append(channel6)
        channels.append(channel7)
        
        let country1 = Country(name: "Russia", code: "ru")
        let country2 = Country(name: "USA", code: "us")
        let country3 = Country(name: "Finland", code: "fi")
        let country4 = Country(name: "China", code: "cn")
        let country5 = Country(name: "Australia", code: "au")
        
        countries.append(country1)
        countries.append(country2)
        countries.append(country3)
        countries.append(country4)
        countries.append(country5)
        
        let quantity1 = Quantity(name: "100")
        let quantity2 = Quantity(name: "50")
        let quantity3 = Quantity(name: "25")
        let quantity4 = Quantity(name: "10")
        
        quantities.append(quantity1)
        quantities.append(quantity2)
        quantities.append(quantity3)
        quantities.append(quantity4)
    }
}
