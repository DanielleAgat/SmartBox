//
//  LoginPresenter.swift
//  SmartBox
//
//  Created by agat levi on 12/03/2022.
//

import Foundation

protocol PresenterView: AnyObject {
    func updateLabel()
}

class LoginPresenter {
    private weak var view: LoginViewController?
    private let model: LoginModel
    
    init(view: LoginViewController, model: LoginModel) {
        self.view = view
        self.model = model
    }
    
    init(with view: LoginViewController) {
        self.view = view
        self.model = LoginModel()
    }
    
    func attachView(_ view: LoginViewController) {
        self.view = view
//        self.view?.update(viewModel: viewModel)
    }
        
    func detachView() {
        self.view = nil
    }
    
    func send(username: String, password: String) {
        model.send(username: username, password: password)
    }
    
    
}
