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
}
