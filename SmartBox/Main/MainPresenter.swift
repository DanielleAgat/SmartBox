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
        if GlobalManager.instance.userManager.userViewModel != nil {
            Logger.instance.logEvent(type: .login, info: "user is already logger in")
            view?.openBoxStateViewController()
        } else if let  username = GlobalManager.instance.defaults.string(forKey: "username") , let password = GlobalManager.instance.defaults.string(forKey: "password") {
            GlobalManager.instance.userManager.userLoggedIn(email: username, password: password, success: { [weak self] in
                self?.view?.openBoxStateViewController()
            }, failure: { error,response in
                Logger.instance.logEvent(type: .login, info: "Could not get logged in user's info")
            })
        }
    }
    
    func signup() {
        Logger.instance.logEvent(type: .signup, info: "starting signup session")
        view?.openSignupViewController()
    }
    
}
