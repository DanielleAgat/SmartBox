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
    let boxId: Int?
    let productLink: String?
    let maxWeight: Double?
    let currentWeight: Double?
    let boxBaseline: Double?
    
    init(email: String, password: String, boxId: Int? = nil, productLink: String? = nil, maxWeight: Double? = nil, currentWeight: Double? = nil, boxBaseline: Double? =  nil) {
        self.email = email
        self.password = password
        self.boxId = boxId
        self.productLink = productLink
        self.currentWeight = currentWeight
        self.boxBaseline = boxBaseline
        self.maxWeight = maxWeight
        Logger.instance.logEvent(type: .login, info: "userViewModel initialized. \nemail: \(self.email) \nbox ID: \(String(describing: self.boxId))\nbox state: \(String(describing: self.currentWeight))\nbox threshold: \(self.boxBaseline)  ")
    }
}
