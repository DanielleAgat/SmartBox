//
//  GlobalManager.swift
//  SmartBox
//
//  Created by Agat Levi on 27/04/2022.
//

import Foundation

class GlobalManager {
    let sessionManager: SMARTBOXHTTPSessionManager
    let loginManager: LoginManagerProtocol
    let settingsManager: SettingsManagerProtocol
    var userManager: UserManagerProtocol
    let baseUrl: String
    let defaults: UserDefaults
    
    private init() {
        sessionManager = SMARTBOXHTTPSessionManager()
        loginManager = LoginManager(sessionManager: sessionManager)
        settingsManager = SettingsManager(sessionManager: sessionManager)
        userManager = UserManager(sessionManager: sessionManager)
        baseUrl = AppConstParams.baseUrl
        defaults = UserDefaults.standard
    }
    
    static let instance = GlobalManager()
    
}
