//
//  SettingsPresenter.swift
//  SmartBox
//
//  Created by Agat Levi on 02/04/2022.
//

import Foundation

protocol SettingsPresenterView: AnyObject {
    func update(viewModel: SettingsViewModel)
}

class SettingsPresenter {
    struct httpPrefix {
        static let http = "http://"
        static let https = "https://"
    }
    
    private weak var view: SettingsViewController?
    private let viewModel: SettingsViewModel
    private let settingsManager: SettingsManagerProtocol
    
    init(view: SettingsViewController, viewModel: SettingsViewModel, settingsManager: SettingsManagerProtocol) {
        self.view = view
        self.viewModel = viewModel
        self.settingsManager = settingsManager
    }
    
    init(with view: SettingsViewController, settingsManager: SettingsManagerProtocol) {
        self.view = view
        self.viewModel = SettingsViewModel()
        self.settingsManager = settingsManager
    }
    
    func attachView(_ view: SettingsViewController) {
        self.view = view
        self.view?.update(viewModel: viewModel)
    }
        
    func detachView() {
        self.view = nil
    }
    
    func setSubmitAvailability() {
        guard let view = view else { return }
        
        if view.boxIdTextBox.hasText && view.thresholdTextBox.hasText && view.ebayLinkTextBox.hasText && view.currentWeightTextBox.hasText {
            view.setSubmitButton(enabled: true)
        } else {
            view.setSubmitButton(enabled: false)
        }
    }
    
    func saveInformationBeforeSubmit(boxID: String, threshold: String, currentWeight: String, productLink: String) {
        var threshold = threshold
        if threshold.hasSuffix("%") {
            threshold.removeLast()
        }
        
        viewModel.threshold = Double(threshold)
        viewModel.productLink = productLink
        viewModel.boxId = Int(boxID)
        viewModel.currentWeight = Double(currentWeight)
    }
    
    func verifyEbayLink(link: String?) -> Bool {
        guard let link = link else { return false}
        
        if link.hasPrefix(httpPrefix.http) || link.hasPrefix(httpPrefix.https) {
            return true
        } else {
            return false
        }
    }
    
    func verifyThreshold(threshold: String?) -> Bool {
        guard var threshold = threshold else { return false }
        if threshold.hasSuffix("%") {
            threshold.removeLast()
        }
        guard  let thresholdInt = Double(threshold) else { return false }
        
        if thresholdInt <= 100 && thresholdInt >= 0 {
            return true
        } else {
            return false
        }
    }
    
    func submit() {
        guard let boxId = viewModel.boxId, let threshold =
                viewModel.threshold, let productLink = viewModel.productLink, let currentWeight = viewModel.currentWeight else { return }
        
        settingsManager.updateSettingsInDB(boxId: Int(boxId), currentWeight: Double(currentWeight), threshold: Double(threshold), productLink: productLink, success: {
            Logger.instance.logEvent(type: .login, info: "updateSettingsInDB success")
            GlobalManager.instance.userManager.getUserInfo(success: { [weak self] in
                Logger.instance.logEvent(type: .login, info: "getUserInfo success")
                self?.saveUserInfo()
                self?.view?.openBoxStateViewController()
            }, failure: { error, response in
                Logger.instance.logEvent(type: .login, info: "getUserInfo failed")
                if let responseObject = response {
                    do {
                        let data = try  JSONSerialization.data(withJSONObject: responseObject, options: [])
                        if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let _ = response["error"] as? String {
    //                        self.view?.showLoginFailedAlert(error: err )
                        }
                    } catch _ {
    //                    self.view?.showLoginFailedAlert(error: error?.localizedDescription ?? "unkown error" )
                    }
                }
            })
        }, failure: { error, response in
            Logger.instance.logEvent(type: .login, info: "updateSettingsInDB failed")
            if let responseObject = response {
                do {
                    let data = try  JSONSerialization.data(withJSONObject: responseObject, options: [])
                    if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let _ = response["error"] as? String {
//                        self.view?.showLoginFailedAlert(error: err )
                    }
                } catch _ {
//                    self.view?.showLoginFailedAlert(error: error?.localizedDescription ?? "unkown error" )
                }
            }
        })
    }
    
    private func saveUserInfo() {
        UserDefaults.standard.set(GlobalManager.instance.userManager.userViewModel?.email, forKey: ConstantsTitles.email)
        UserDefaults.standard.set(GlobalManager.instance.userManager.userViewModel?.password, forKey: ConstantsTitles.password)
    }
    
    func clearInformation() {
        viewModel.threshold = nil
        viewModel.productLink = nil
        viewModel.boxId = nil
    }
    
}
