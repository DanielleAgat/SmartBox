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
    let currentWeightTitleText: String
    let productLinkTitleText: String
    let submitButtonText: String
    
    //Values:
    var boxId: Int?
    var threshold: Double?
    var currentWeight: Double?
    var productLink: String?
    
    init() {
        boxIdTitleText = ConstantsTitles.boxID
        ThresholdTitleText = ConstantsTitles.threshold
        currentWeightTitleText = ConstantsTitles.currentWeight
        productLinkTitleText = ConstantsTitles.productLink
        submitButtonText = Strings.submitButton
    }
    
}
