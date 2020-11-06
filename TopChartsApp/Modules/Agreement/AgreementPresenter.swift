//
//  AgreementPresenter.swift
//  TopChartsApp
//
//  Created by Kir Pir on 15.08.2020.
//  Copyright © 2020 Kirill_Presnyakov. All rights reserved.
//

import UIKit

protocol AgreementPresenterProtocol {
    init(view: AgreementViewControllerProtocol)

    func buttonPressed(tag: Int, text: String)
}

class AgreementPresenter: AgreementPresenterProtocol {
    
    private unowned let view: AgreementViewControllerProtocol
    
    required init(view: AgreementViewControllerProtocol) {
        self.view = view
    }
    
    func pressDisagree() {
        view.showAlert(with: "Вы уверены?",
                       and: "Приложение будет закрыто") { (alert) in
            let okAction = UIAlertAction(title: "Да",
                                         style: .default) { _ in
                                            exit(0)
            }
            alert.addAction(okAction)
        }
    }
    
    func pressAgree(text: String) {
        if text == "Привет! Назови себя" {
            view.showEnterNameAlert(with: "Вы забыли заполнить поле имени",
                                    and: "Пожалуйста введите своё имя")
        } else {
            moveToTheNextView()
        }
    }
    
    func moveToTheNextView() {
        view.showSettingsVC()
    }
    
    func buttonPressed(tag: Int, text: String) {
        if tag == 0 {
            pressDisagree()
        } else {
            pressAgree(text: text)
        }
    }
}
