//
//  UserViewModel.swift
//  SmartBox
//
//  Created by Agat Levi on 27/04/2022.
//

import Foundation

struct UserViewModel {
    let email: String
    let password: String
    let boxId: String?
    let ebayConnection: String?
    let lastOrderDate: String?
    let weight: Float?
    let boxState: String?
    let boxBaseline: String?
    
    init(email: String, password: String, boxId: String? = nil, ebayConnection: String? = nil, lastOrderDate: String? = nil, weight: Float? = nil, boxState: String? = nil, boxBaseline: String? =  nil) {
        self.email = email
        self.password = password
        self.boxId = boxId
        self.ebayConnection = ebayConnection
        self.lastOrderDate = lastOrderDate
        self.boxState = boxState
        self.boxBaseline = boxBaseline
        self.weight = weight
        Logger.instance.logEvent(type: .login, info: "userViewModel initialized. \nemail: \(self.email) \nbox ID: \(String(describing: self.boxId))\nbox state: \(self.boxState)\nbox threshold: \(self.boxBaseline)  ")
    }
}
