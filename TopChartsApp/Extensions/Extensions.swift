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
                    and message: String,
                    with complition: @escaping (UIAlertController) -> Void) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let noAction = UIAlertAction(title: "Нет", style: .default)
        alert.addAction(noAction)
        complition(alert)
        
        present(alert, animated: true)
    }
    
    func showEnterNameAlert(with title: String,
                           and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ок",
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
           showEnterNameAlert(with: "Некорректный формат", and: "Пожалуйста введите своё имя")
            userNameTextField.text = nil
        } else {
        helloUserLabel.text = "Привет, \(userNameTextField.text ?? "")!"
        userNameTextField.resignFirstResponder()
        }
       return true
    }
}

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
