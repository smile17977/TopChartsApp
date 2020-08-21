//
//  AgreementViewController.swift
//  TopChartsApp
//
//  Created by Kir Pir on 15.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol BaseViewControllerProtocol: UIViewController {

}

protocol AgreementViewControllerProtocol: BaseViewControllerProtocol {
    
}

class AgreementViewController: UIViewController {

    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet var helloUserLabel: UILabel!
    @IBOutlet var enterYourNameLabel: UILabel!
    @IBOutlet var userNameTextField: UITextField!
    
    // MARK: Properties
    
    var presenter: AgreementPresenterProtocol!

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        
        configureTextField()
        configureEnterYourNameLabel()
        
        view.backgroundColor = .lightGray
        
        setLabel(for: helloUserLabel, "Hello, User", .blue, 20)
        
        
        
        for button in actionButtons {
            if button.tag == 0 {
                setButton(for: button, "I disagree", .white)
            } else {
                setButton(for: button, "I agree", .white)
            }
        }
    }

    
    private func setButton(for button: UIButton, _ title: String, _ titleColor: UIColor) {
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        
        
    }
    
    private func setLabel(for label: UILabel,_ text: String,_ textColor: UIColor = .blue, _ fontSize: CGFloat = 20) {
        
        label.text = text
        label.textColor = textColor
        label.font = label.font.withSize(fontSize)
        label.text = "Hello, User"
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 0 {
            
            showAlert(with: "Are you sure?", and: "The app will be closed")
            
        } else {
            if helloUserLabel.text == "Hello, User" {
                showEnterNameAlert(with: "Forgot write your name?", and: "Please enter your name")
            } else {
                performSegue(withIdentifier: "showHome", sender: nil)
            }
        }
        
    }
    
    func configureEnterYourNameLabel() {
        
        enterYourNameLabel.text = "Пожалуйста, назовите себя"
    }
    
    
    func configureTextField() {
        
        userNameTextField.returnKeyType = .done
        userNameTextField.enablesReturnKeyAutomatically = true
        userNameTextField.autocorrectionType = .no
        userNameTextField.clearButtonMode = .whileEditing
    }
    
    func nameEntered() {
        userNameTextField.text = enterYourNameLabel.text
    }
    
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

extension UIViewController {
     func showAlert(with title: String,
                           and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let noAction = UIAlertAction(title: "No", style: .default)
        let okAction = UIAlertAction(title: "Yes",
                                     style: .default) { _ in
                                        exit(0)
        }
        
        alert.addAction(noAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension UIViewController {
    func showEnterNameAlert(with title: String,
                           and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default) { _ in
                                        
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension AgreementViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        if let _ = Double(userNameTextField.text!) {
           showEnterNameAlert(with: "Wrong format", and: "Please enter your name")
            userNameTextField.text = nil
        } else {
        helloUserLabel.text = "Hello, \(userNameTextField.text ?? "")"
        userNameTextField.resignFirstResponder()
        }
       return true
    }
    
}




