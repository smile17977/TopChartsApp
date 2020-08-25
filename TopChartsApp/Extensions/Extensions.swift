//
//  Extensions.swift
//  TopChartsApp
//
//  Created by Kir Pir on 15.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard {
    
    case main
    case home
        
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


