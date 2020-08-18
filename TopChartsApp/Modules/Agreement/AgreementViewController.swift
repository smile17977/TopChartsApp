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
    
    // MARK: Properties
    
    var presenter: AgreementPresenterProtocol!

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        setLabel(for: helloUserLabel, "Hello User", .blue, 45)
        
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
    
    private func setLabel(for label: UILabel,_ text: String,_ textColor: UIColor, _ fontSize: CGFloat) {
        
        label.text = text
        label.textColor = textColor
        label.font = helloUserLabel.font.withSize(fontSize)
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 0 {
            
            showAlert(with: "Are you sure?", and: "The app will be closed")
//            presenter.pressCancel()
            
        } else {
            
            performSegue(withIdentifier: "showHome", sender: self)
           
            }
        
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



