//
//  AgreementViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 15.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol: class {
    func showAlert(with title: String, and message: String)
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
    
    // MARK: Properties
    
    private var presenter: AgreementPresenterProtocol!

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AgreementPresenter.init(view: self)
        userNameTextField.delegate = self
        
        view.backgroundColor = .lightGray
        
        configureTextField()
        configureEnterYourNameLabel()
        setLabel(for: helloUserLabel, "Hello, User", .blue, 20)
        configureButtons(for: actionButtons)
        
    }
    
    // MARK: IBActions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 0 {
            presenter.pressDisagree()
        } else {
            
            if helloUserLabel.text == "Hello, User" {
                presenter.pressAgree()
            } else {
                presenter.moveToTheNextView()
            }
        }
    }
    
    // MARK: UI
    
    private func setButton(for button: UIButton, _ title: String, _ titleColor: UIColor) {
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
    }
    
    private func configureButtons(for buttons: [UIButton]) {
        
        for button in buttons {
            if button.tag == 0 {
                setButton(for: button, "I disagree", .white)
            } else {
                setButton(for: button, "I agree", .white)
            }
        }
    }
    
    private func setLabel(for label: UILabel,_ text: String,_ textColor: UIColor = .blue, _ fontSize: CGFloat = 20) {
        
        label.text = text
        label.textColor = textColor
        label.font = label.font.withSize(fontSize)
        label.text = "Hello, User"
    }
    
    private func configureEnterYourNameLabel() {
        
        enterYourNameLabel.text = "Пожалуйста, назовите себя"
    }
    
    
    private func configureTextField() {
        
        userNameTextField.returnKeyType = .done
        userNameTextField.enablesReturnKeyAutomatically = true
        userNameTextField.autocorrectionType = .no
        userNameTextField.clearButtonMode = .whileEditing
    }
    
    private func nameEntered() {
        
        userNameTextField.text = enterYourNameLabel.text
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showHome" {
            let topChartsVC = segue.destination as! UINavigationController
            let top = topChartsVC.topViewController as! TopChartsTableViewController
            top.userName = helloUserLabel.text
        }
    }
    
    @IBAction func unwindSegueToMainViewController(for unwindSegue: UIStoryboardSegue) {
        
        setLabel(for: helloUserLabel, "Hello, User ")
        userNameTextField.text = nil
    }
}

extension AgreementViewController: AgreementViewControllerProtocol {
    
    func showHome() {
        performSegue(withIdentifier: "showHome", sender: nil)
    }
}






