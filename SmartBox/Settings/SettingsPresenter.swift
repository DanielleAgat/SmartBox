//
//  SettingsPresenter.swift
//  SmartBox
//
//  Created by Agat Levi on 02/04/2022.
//

import Foundation

class SettingsPresenter {
    private weak var view: SettingsViewController?
    private let model: SettingsModel
    
    init(view: SettingsViewController, model: SettingsModel) {
        self.view = view
        self.model = model
    }
    
    init(with view: SettingsViewController) {
        self.view = view
        self.model = SettingsModel()
    }
    
    func attachView(_ view: SettingsViewController) {
        self.view = view
//        self.view?.update(viewModel: viewModel)
    }
        
    func detachView() {
        self.view = nil
    }
    
    func setSubmitAvailability() {
        guard let view = view else { return }
        
        if !view.boxIdTextBox.isEmpty() && !view.thresholdTextBox.isEmpty() && !view.ebayLinkTextBox.isEmpty(), let accountTitle = view.ebayAccountButton.currentTitle, accountTitle != SettingsViewController.titles.accountDisconnected {
            view.setSubmitButton(enabled: true)
        } else {
            view.setSubmitButton(enabled: false)
        }
    }
    
    func connectToEbayAccount() -> String? {
        //TODO: open a webview with ebay sign in url
        return "Agat"
    }
    
    func setAccountButtonText() -> String {
        var text: String
        if let name = view?.ebayUserName {
            text = name.appending(SettingsViewController.titles.isConnected)
        } else {
            text = SettingsViewController.titles.accountDisconnected
        }
        return text
    }
}
