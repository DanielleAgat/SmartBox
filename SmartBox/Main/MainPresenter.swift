//
//  MainPresenter.swift
//  SmartBox
//
//  Created by Agat Levi on 11/05/2022.
//

import Foundation
import UIKit

class MainPresenter {
    var view: MainViewController?
    
    func checkIfAlreadyLoggedIn() {
        if let username = UserDefaults.standard.string(forKey: ConstantsTitles.email), let password = UserDefaults.standard.string(forKey: ConstantsTitles.password) {
            Logger.instance.logEvent(type: .login, info: "user is already logged in")
            GlobalManager.instance.userManager.userLoggedIn(email: username, password: password, success: { [weak self] in
                self?.view?.openBoxStateViewController()
            }, failure: { [weak self] error,response in
                Logger.instance.logEvent(type: .login, info: "user isn't logged in yet")
            })
        }
    }
    
    func signup() {
        Logger.instance.logEvent(type: .signup, info: "starting signup session")
        view?.openSignupViewController()
    }
    
}
