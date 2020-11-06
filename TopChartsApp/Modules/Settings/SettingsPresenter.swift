//
//  SettingsPresenter.swift
//  TopChartsApp
//
//  Created by Kir Pir on 08.09.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import Foundation

protocol SettingsPresenterProtocol {
    init(view: SettingsViewControllerProtocol, userName: String)
    
    func getChannels(for carrier: String) -> [Channel]
    func getPickerViewsCount(tag: Int) -> Int
    func setupAttributedTitleForRow(tag: Int, row: Int) -> NSAttributedString
    func didSelectRow(tag: Int, row: Int)
    func moveToTopChartsVC()
    func getURLString() -> String
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    // MARK: Properties
    private var jsonGenerator = JsonGenerator()
    private let view: SettingsViewControllerProtocol!
    private var channelsByCarriers = [Channel]()
    
    private var urlCarrier: String?
    private var urlChannel: String?
    private var urlCountry: String?
    private var urlQuantity: String?
    
    private var userName: String
    
    private var carriers: [Carrier] {
        jsonGenerator.carriers
    }
    
    private var countries: [Country] {
        jsonGenerator.countries
    }
    
    private var quantities: [Quantity] {
        jsonGenerator.quantities
    }
    
    private var channels: [Channel] {
        jsonGenerator.channels
    }
    
    required init(view: SettingsViewControllerProtocol, userName: String) {
        self.view = view
        self.userName = userName
        channelsByCarriers = getChannels(for: carriers.first!.name)
    }
    
    // MARK: Methods
    func getChannels(for carrier: String) -> [Channel] {
        let channels = self.channels.filter { (channel) -> Bool in
            channel.typeOfCarrier == carrier
        }
        return channels
    }
    
    func getPickerViewsCount(tag: Int) -> Int {
        switch tag {
        case 0:
            return carriers.count
        case 1:
            return channelsByCarriers.count
        case 2:
            return countries.count
        default:
            return quantities.count
        }
    }
    
    func setupAttributedTitleForRow(tag: Int, row: Int) -> NSAttributedString {
        var title = ""
        
        switch tag {
        case 0:
            let carrier = carriers[row]
            title = carrier.name
            urlCarrier = carriers[row].code
        case 1:
            let channel = channelsByCarriers[row]
            title = channel.name
            urlChannel = channelsByCarriers[row].code
        case 2:
            let country = countries[row]
            title = country.name
            urlCountry = countries[row].code
        default:
            let quantity = quantities[row]
            title = quantity.name
            urlQuantity = quantity.name
        }
        
        let attrString = NSAttributedString(string: title,
                                            attributes: [.foregroundColor:Colors.orange])
        return attrString
    }
    
    func didSelectRow(tag: Int, row: Int) {
        switch tag {
        case 0:
            let carrier = carriers[row]
            channelsByCarriers = getChannels(for: carrier.name)
            urlCarrier = carrier.code
            view.reloadPickerView()
        case 1:
            urlChannel = channelsByCarriers[row].code
        case 2:
            urlCountry = countries[row].code
        default:
            urlQuantity = quantities[row].name
        }
    }
    
    func moveToTopChartsVC() {
        view.showTopChartsVC()
    }
    
    func getURLString() -> String {
        let url = Requests.shared.configureURL(country: urlCountry ?? "",
                                               channel: urlChannel ?? "",
                                               carrier: urlCarrier ?? "",
                                               quantity: urlQuantity ?? "")
        return url
    }
}
