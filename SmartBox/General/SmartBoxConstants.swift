//
//  SmartBoxConstants.swift
//  SmartBox
//
//  Created by Agat Levi on 27/04/2022.
//

import Foundation

struct ConstantsAPI {
    static let tPassword = "password"
    static let tEmail = "email"
    static let tBoxId = "box_id"
    static let tCurrentWeight = "current_weight"
    static let tBoxThreshold = "baseline"
    static let tAmazonLink = "amazon_link"
    
}

struct ConstantsTitles {
    static let email = "Email"
    static let password = "Password"
    static let login = "Login"
    static let signup = "Signup"
    static let boxID = "Box ID"
    static let threshold = "Threshold"
    static let currentWeight = "Current weight"
    static let productLink = "Amazon link"
}

struct AppConstParams {
    static let baseUrl = "https://smart-box-com.herokuapp.com"
}

struct Strings {
    static let letMeFixItButton = "Let me fix it"
    static let invalidInput = "Invalid input"
    static let invalidEmailMessage = "Your email looks fishy, are you sure it is correct?"
    static let invalidLinkMessage = "Are you sure this is the correct link? \nIs your threshold is between 0-100 ? Please fix and try again !"
    static let missingFieldsTitle = "Missing fields"
    static let missingFieldsMessage = "One or more fields are missing!\nPlease fill it before you continue."
    static let popUpConfirmation = "OK"
    static let signupFailedTitle = "Signup failed"
    static let loginFailedTitle = "Login failed"
    static let logoutMenuItem = "Logout"
    static let submitButton = "Submit"
}

struct StoryBoards {
    static let navigationController = "NavigationController"
    static let signup = "Signup"
    static let login = "Login"
    static let settings = "Settings"
    static let boxState = "BoxState"
    static let main = "Main"
}
