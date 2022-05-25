//
//  SettingsViewModel.swift
//  SmartBox
//
//  Created by Agat Levi on 20/04/2022.
//

import Foundation

class SettingsViewModel {
    //Titles:
    let boxIdTitleText: String
    let ThresholdTitleText: String
    let ebayProductLinkTitleText: String
    let ebayAccountTitleText: String
    let submitButtonText: String
    
    //Values:
    var boxId: String?
    var threshold: Int?
    var productLink: String? //TODO: Check if easy to change to URL? type
    var ebayAccount: Bool //TODO: Change to ebay account object and set it according to what is needed in order to make a purchase
    var isAccountConnected: Bool
    
    init() {
        boxIdTitleText = "Box ID"
        ThresholdTitleText = "Threshold"
        ebayProductLinkTitleText = "product link"
        ebayAccountTitleText = "eBay account"
        submitButtonText = "Submit"
        
        ebayAccount = false
        isAccountConnected = false
    }
    
}
