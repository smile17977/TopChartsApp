//
//  AgreementViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 15.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol: class {
    func showAlert(with title: String, and message: String, with complition: @escaping (UIAlertController) -> Void)
    func showEnterNameAlert(with title: String, and message: String)
}

protocol AgreementViewControllerProtocol: BaseViewControllerProtocol {
    func showHome()
}

class AgreementViewController: UIViewController {

    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet var helloUserLabel: UILabel!
    @IBOutlet var enterYourNameLabel: UILabel!
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var agreementTextView: UITextView!
    // MARK: Properties
    
    private var presenter: AgreementPresenterProtocol!

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = AgreementPresenter.init(view: self)
        userNameTextField.delegate = self
        
        setBackgroundGradient()
        setAgreementTextView()
        configureTextField()
        setLabel(for: helloUserLabel, "Привет! Назови себя", .blue, 20)
        configureButtons(for: actionButtons)
    }
    
    // MARK: IBActions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 0 {
            presenter.pressDisagree()
        } else {
            if helloUserLabel.text == "Привет! Назови себя" {
                presenter.pressAgree()
            } else {
                presenter.moveToTheNextView()
            }
        }
    }
    
    // MARK: UI
    
    private func setAgreementTextView() {
        
        agreementTextView.font = UIFont(
            name: "AppleSDGothicNeo-Regular",
            size: 23)
        agreementTextView.backgroundColor = UIColor.gray
        agreementTextView.layer.cornerRadius = 10
        agreementTextView.isEditable = false
        
    }
    
    private func setButton(for button: UIButton, _ title: String, _ titleColor: UIColor) {
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
    }
    
    private func configureButtons(for buttons: [UIButton]) {
        
        for button in buttons {
            if button.tag == 0 {
                setButton(for: button, "Не согласен", .white)
            } else {
                setButton(for: button, "Согласен", .white)
            }
        }
    }
    
    private func setLabel(for label: UILabel,_ text: String,_ textColor: UIColor = .blue, _ fontSize: CGFloat = 20) {
        
        label.text = text
        label.textColor = textColor
        label.font = label.font.withSize(fontSize)
    }
    
    private func configureTextField() {
        
        userNameTextField.returnKeyType = .done
        userNameTextField.enablesReturnKeyAutomatically = true
        userNameTextField.autocorrectionType = .no
        userNameTextField.clearButtonMode = .whileEditing
        userNameTextField.backgroundColor = .gray
    }
    
    private func nameEntered() {
        
        userNameTextField.text = enterYourNameLabel.text
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showSettings" {
            let settingsVC = segue.destination as! SettingsViewController
            settingsVC.userName = helloUserLabel.text
//            let topChartsVC = segue.destination as! UINavigationController
//            let top = topChartsVC.topViewController as! TopChartsTableViewController
//            top.userName = helloUserLabel.text
        }
    }
    
    @IBAction func unwindSegueToMainViewController(for unwindSegue: UIStoryboardSegue) {

        setLabel(for: helloUserLabel, "Привет! Назови себя")
        userNameTextField.text = nil
    }
}

extension AgreementViewController: AgreementViewControllerProtocol {
    
    func showHome() {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }
}

extension UIViewController {
    
    func setBackgroundGradient () {
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.systemGray2.cgColor, UIColor.systemOrange.cgColor]
        layer.startPoint = CGPoint(x: 1, y: 0.1)
        layer.endPoint = CGPoint(x:0.9, y:0.9)
        view.layer.insertSublayer(layer, at: 0)
    }
    
}






