//
//  SettingsViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 31.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol: class {
    func reloadPickerView()
    func showTopChartsVC()
}

class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var mediaProductPicker: UIPickerView!
    @IBOutlet var typeOfChanelPicker: UIPickerView!
    @IBOutlet var countryPicker: UIPickerView!
    @IBOutlet var quantityPicker: UIPickerView!
    
    @IBOutlet var showTopChartsButton: UIButton!
    
    // MARK: Properties
    var presenter: SettingsPresenterProtocol!
    
    private var channelsByCarriers = [Channel]()
    var userName: String!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setDelegatesForPickerViews()
    }
    
    private func setupView() {
        setupNavigationBar()
        view.setGradientBackground(colorOne: Colors.darkGreen,
                                   colorTwo: Colors.lightGreen)
        configureButton(for: showTopChartsButton,
                        title: "Показать",
                        titleColor: .white)
    }
    
    private func setupNavigationBar() {
        title = "Настройки"
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Colors.lightGreen
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navBar?.standardAppearance = navBarAppearance
        navBar?.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setDelegatesForPickerViews() {
        mediaProductPicker.delegate = self
        typeOfChanelPicker.delegate = self
        countryPicker.delegate = self
        quantityPicker.delegate = self
    }
    
    private func configureButton(for button: UIButton,
                                 title: String,
                                 titleColor: UIColor) {
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = UIColor(red: 76.0/255.0,
                                         green: 125.0/255.0,
                                         blue: 50.0/255.0,
                                         alpha: 0.5)
        button.layer.cornerRadius = 10
    }
    
    private func deselectPickerViewsAfterUpdate() {
        countryPicker.selectRow(0,
                                inComponent: 0,
                                animated: true)
        quantityPicker.selectRow(0,
                                 inComponent: 0,
                                 animated: true)
        typeOfChanelPicker.selectRow(0,
                                     inComponent: 0,
                                     animated: true)
    }
    
    // MARK: IB Actions
    @IBAction func showButtonPressed(_ sender: Any) {
        presenter.moveToTopChartsVC()
    }
    
    @IBAction func unwindSegueToSettingsViewController(for unwindSegue: UIStoryboardSegue) {
    }
}

// MARK: UIPickerViewDataSource
extension SettingsViewController: UIPickerViewDataSource  {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int) -> Int {
        presenter.getPickerViewsCount(tag: pickerView.tag)
    }
}

// MARK: UIPickerViewDelegate
extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        presenter.setupAttributedTitleForRow(tag: pickerView.tag, row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        presenter.didSelectRow(tag: pickerView.tag, row: row)
    }
}

// MARK: SettingsViewControllerProtocol
extension SettingsViewController: SettingsViewControllerProtocol {
    func reloadPickerView() {
        typeOfChanelPicker.reloadAllComponents()
        deselectPickerViewsAfterUpdate()
    }
    
    func showTopChartsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let topChartsVC = storyboard.instantiateViewController(identifier: "TopChartsVC") as! TopChartsTableViewController
        self.navigationController?.pushViewController(topChartsVC, animated: true)
        let url = presenter.getURLString()
        topChartsVC.presenter = TopChartsPresenter.init(view: topChartsVC, stringURL: url)
    }
}
