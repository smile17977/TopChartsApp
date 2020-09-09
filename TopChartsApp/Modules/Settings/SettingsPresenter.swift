//
//  SettingsPresenter.swift
//  TopChartsApp
//
//  Created by Kir Pir on 08.09.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation

protocol SettingsPresenterProtocol {
    init(view: SettingsViewControllerProtocol)
    
    func getCarriersCount() -> Int
    func getChannelsCount() -> Int
    func getCountriesCount() -> Int
    func getQuantitiesCount() -> Int
    
    func getChannels(for carrier: String) -> [Channel]
    
    var carriers: [Carrier] { get }
    var channels: [Channel] { get }
    var channelsByCarriers: [Channel] { get }
    var countries: [Country] { get }
    var quantities: [Quantity] { get }
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    let view: SettingsViewControllerProtocol!
    var jsonGenerator = JsonGenerator()
    
    required init(view: SettingsViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: Properties
    
    var carriers: [Carrier] {
        jsonGenerator.carriers
    }
    
    var countries: [Country] {
        jsonGenerator.countries
    }
    
    var quantities: [Quantity] {
        jsonGenerator.quantities
    }
    
    var channels: [Channel] {
        jsonGenerator.channels
    }
    
    var channelsByCarriers: [Channel] {
        getChannels(for: carriers.first!.name)
    }
    
    // MARK: Methods
    
    func getCarriersCount() -> Int {
        carriers.count
    }
    
    func getChannelsCount() -> Int {
        channels.count
    }
    
    func getCountriesCount() -> Int {
        countries.count
    }
    
    func getQuantitiesCount() -> Int {
        quantities.count
    }
    
    func getChannels(for carrier: String) -> [Channel] {
        let channels = self.channels.filter { (channel) -> Bool in
            channel.typeOfCarrier == carrier
        }
        return channels
    }
}
