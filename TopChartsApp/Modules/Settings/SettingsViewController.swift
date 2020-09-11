//
//  SettingsViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 31.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol: class {
    
}

class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var mediaProductPicker: UIPickerView!
    @IBOutlet var typeOfChanelPicker: UIPickerView!
    @IBOutlet var countryPicker: UIPickerView!
    @IBOutlet var quantityPicker: UIPickerView!
    
    @IBOutlet var showTopChartsButton: UIButton!
    @IBOutlet var defaultPickersButton: UIButton!
    
    // MARK: Properties
    var requests = Requests.shared
    var presenter: SettingsPresenterProtocol!
    
    var urlCarrier = ""
    var urlChannel = ""
    var urlCountry = ""
    var urlQuantity = ""
    
    var channelsByCarriers = [Channel]()
    var userName: String!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SettingsPresenter.init(view: self)
        channelsByCarriers = presenter.channels
        view.setGradientBackground(colorOne: Colors.darkGreen, colorTwo: Colors.lightGreen)
        setDelegatesForPickerViews()
        configureButton(for: showTopChartsButton, title: "Показать", titleColor: .white)
        configureButton(for: defaultPickersButton, title: "Сбросить", titleColor: .white)
    }
    
    func setDelegatesForPickerViews() {
        
        mediaProductPicker.delegate = self
        typeOfChanelPicker.delegate = self
        countryPicker.delegate = self
        quantityPicker.delegate = self
    }
    
    func configureButton(for button: UIButton, title: String, titleColor: UIColor) {
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = UIColor(red: 76.0/255.0, green: 125.0/255.0, blue: 50.0/255.0, alpha: 0.5)
        button.layer.cornerRadius = 10
    }
    
    func deselectPickerViewsAfterUpdate() {
        countryPicker.selectRow(0, inComponent: 0, animated: true)
        quantityPicker.selectRow(0, inComponent: 0, animated: true)
        typeOfChanelPicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHome" {
            let navigationVC = segue.destination as! UINavigationController
            let topChartsVC = navigationVC.topViewController as! TopChartsTableViewController
            topChartsVC.userName = self.userName
            topChartsVC.urlString = requests.configureURL(country: urlCountry, channel: urlChannel, carrier: urlCarrier, quantity: urlQuantity)
            print(topChartsVC.urlString!)
        }
    }
    
     @IBAction func unwindSegueToSettingsViewController(for unwindSegue: UIStoryboardSegue) {
        }
    
    @IBAction func defaultPickersButtonPressed(_ sender: Any) {
        mediaProductPicker.selectRow(0, inComponent: 0, animated: true)
        countryPicker.selectRow(0, inComponent: 0, animated: true)
        quantityPicker.selectRow(0, inComponent: 0, animated: true)
        typeOfChanelPicker.selectRow(0, inComponent: 0, animated: true)
    }
}

   

// MARK: UIPickerViewDataSource
extension SettingsViewController: UIPickerViewDataSource  {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case mediaProductPicker:
            return presenter.getCarriersCount()
        case typeOfChanelPicker:
            return channelsByCarriers.count
        case countryPicker:
            return presenter.getCountriesCount()
        case quantityPicker:
            return presenter.getQuantitiesCount()
        default:
            return 0
        }
    }
}

// MARK: UIPickerViewDelegate
extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var title = ""
        
        switch pickerView {
        case mediaProductPicker:
            let carrier = presenter.carriers[row]
            title = carrier.name
            urlCarrier = presenter.carriers[row].code
        case typeOfChanelPicker:
            let channel = channelsByCarriers[row]
            title = channel.name
            urlChannel = channelsByCarriers[row].code
        case countryPicker:
            let country = presenter.countries[row]
            title = country.name
            urlCountry = presenter.countries[row].code
        case quantityPicker:
            let quantity = presenter.quantities[row]
            title = quantity.name
            urlQuantity = quantity.name
        default:
            break
        }
        
        let attrString = NSAttributedString(string: title,
                                            attributes: [.foregroundColor:Colors.orange])
        return attrString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case mediaProductPicker:
            let carrier = presenter.carriers[row]
            channelsByCarriers = presenter.getChannels(for: carrier.name)
            urlCarrier = carrier.code
            typeOfChanelPicker.reloadAllComponents()
            deselectPickerViewsAfterUpdate()
        case typeOfChanelPicker:
            urlChannel = channelsByCarriers[row].code
        case countryPicker:
            urlCountry = presenter.countries[row].code
        case quantityPicker:
            urlQuantity = presenter.quantities[row].name
        default:
            break
        }
    }
    
}

extension SettingsViewController: SettingsViewControllerProtocol {
}
