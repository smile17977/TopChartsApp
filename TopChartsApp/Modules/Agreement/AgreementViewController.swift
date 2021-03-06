//
//  AgreementViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 15.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol: class {
    func showAlert(with title: String,
                   and message: String,
                   with complition: @escaping (UIAlertController) -> Void)
    func showEnterNameAlert(with title: String,
                            and message: String)
}

protocol AgreementViewControllerProtocol: BaseViewControllerProtocol {
    func showSettingsVC()
}

class AgreementViewController: UIViewController {

    // MARK: IB Outlets
    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet var helloUserLabel: UILabel!
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var agreementTextView: UITextView!
    
    // MARK: Properties
    private var presenter: AgreementPresenterProtocol!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = AgreementPresenter.init(view: self)
        setupView()
    }
    
    // MARK: IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        presenter.buttonPressed(tag: sender.tag, text: helloUserLabel.text!)
    }
    
    // MARK: UI
    private func setupView() {
        view.setGradientBackground(colorOne: Colors.darkGreen,
                                   colorTwo: Colors.lightGreen)
        setLabel(for: helloUserLabel,
                 "Привет! Назови себя",
                 Colors.orange, 20)
        setAgreementTextView()
        
        configureTextField()
        configureButtons(for: actionButtons)
    }
    
    private func setAgreementTextView() {
        
        agreementTextView.layer.cornerRadius = 10
        agreementTextView.isEditable = false
        agreementTextView.font = UIFont(
            name: "AppleSDGothicNeo-Regular",
            size: 23)
        agreementTextView.backgroundColor = UIColor(red: 23.0/255.0,
                                                    green: 61.0/255.0,
                                                    blue: 28.0/255.0,
                                                    alpha: 0.3)
    }
    
    private func setButton(for button: UIButton,
                           _ title: String,
                           _ titleColor: UIColor) {
        
        button.layer.cornerRadius = 10
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = UIColor(red: 76.0/255.0,
                                         green: 125.0/255.0,
                                         blue: 50.0/255.0,
                                         alpha: 0.5)
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
    
    private func setLabel(for label: UILabel,
                          _ text: String,
                          _ textColor: UIColor = Colors.orange,
                          _ fontSize: CGFloat = 20) {
        
        label.text = text
        label.textColor = textColor
        label.font = label.font.withSize(fontSize)
    }
    
    private func configureTextField() {
        
        userNameTextField.delegate = self
        userNameTextField.returnKeyType = .done
        userNameTextField.enablesReturnKeyAutomatically = true
        userNameTextField.autocorrectionType = .no
        userNameTextField.clearButtonMode = .whileEditing
        userNameTextField.backgroundColor = UIColor(red: 76.0/255.0,
                                                    green: 125.0/255.0,
                                                    blue: 50.0/255.0,
                                                    alpha: 0.5)
    }
    
    @IBAction func unwindSegueToMainViewController(for unwindSegue: UIStoryboardSegue) {

        setLabel(for: helloUserLabel, "Привет! Назови себя")
        userNameTextField.text = nil
    }
}

// MARK: AgreementViewControllerProtocol
extension AgreementViewController: AgreementViewControllerProtocol {
    func showSettingsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(identifier: "SettingsVC") as! SettingsViewController
        let navigationVC = UINavigationController(rootViewController: settingsVC)
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: true, completion: nil)
        settingsVC.presenter = SettingsPresenter.init(view: settingsVC, userName: userNameTextField.text!)
    }
}






