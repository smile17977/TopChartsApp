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
    
    func pressDisagree()
    func pressAgree()
    func moveToTheNextView()
    
}

class AgreementPresenter: AgreementPresenterProtocol {
    
    
    
    private unowned let view: AgreementViewControllerProtocol
    
    required init(view: AgreementViewControllerProtocol) {
        self.view = view
    }
    
    func pressDisagree() {
        view.showAlert(with: "Are you sure?", and: "The app will be closed")
    }
    
    func pressAgree() {
        view.showEnterNameAlert(with: "Forgot write your name?", and: "Please enter your name")
    }
    
    func moveToTheNextView() {
        view.showHome()
    }
    
}


