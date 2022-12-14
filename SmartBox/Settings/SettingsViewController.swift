//
//  SettingsViewController.swift
//  SmartBox
//
//  Created by Agat Levi on 09/04/2022.
//

import UIKit

protocol SettingsViewControllerProtocol {
    func update(viewModel: SettingsViewModel)
}

class SettingsViewController: UIViewController {

    var presenter: SettingsPresenter!

    @IBOutlet var submitButton: UIButton!
    @IBOutlet var boxIdTextBox: UITextField!
    @IBOutlet var thresholdTextBox: UITextField!
    @IBOutlet var currentWeightTextBox: UITextField!
    @IBOutlet var ebayLinkTextBox: UITextField!
    @IBOutlet var checkmarkSuccess: UIImageView!
    
    //Labels:
    @IBOutlet var boxIdLabel: UILabel!
    @IBOutlet var thresholdLabel: UILabel!
    @IBOutlet var currentWeightLabel: UILabel!
    @IBOutlet var ebayLinkLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(self)
        presenter.setSubmitAvailability()
        submitButton.isHidden = false
        checkmarkSuccess.isHidden = true
        navigationItem.title = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    
    @IBAction func boxIdextBoxEdited(_ sender: UITextField) {
        presenter.setSubmitAvailability()
    }
    
    @IBAction func thresholdTextBoxEdited(_ sender: UITextField) {
        presenter.setSubmitAvailability()
    }
    
    @IBAction func currentWeightTextBoxEdited(_ sender: Any) {
        presenter.setSubmitAvailability()
    }
    
    @IBAction func ebayLinkTextBoxEdited(_ sender: UITextField) {
        presenter.setSubmitAvailability()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if !presenter.verifyEbayLink(link: ebayLinkTextBox.text) || !presenter.verifyThreshold(threshold: thresholdTextBox.text) {
            let okAction = UIAlertAction(title: Strings.popUpConfirmation, style: .default, handler: nil)
            showAlertViewController(title: Strings.invalidInput, message: Strings.invalidLinkMessage , actions: [okAction], animated: true, completion: nil)
            return
        }
        
        guard let boxId = boxIdTextBox.text, let threshold = thresholdTextBox.text, let currentWeight = currentWeightTextBox.text, let productLink = ebayLinkTextBox.text else {
            let okAction = UIAlertAction(title: Strings.popUpConfirmation, style: .default, handler: nil)
            showAlertViewController(title: Strings.missingFieldsTitle, message: Strings.missingFieldsMessage, actions: [okAction], animated: true, completion: nil)
            return
        }
        presenter.saveInformationBeforeSubmit(boxID: boxId, threshold: threshold, currentWeight: currentWeight, productLink: productLink)
        
        submitButton.isHidden = true
        checkmarkSuccess.isHidden = false
        presenter.submit()
    }
    
    func setSubmitButton(enabled: Bool) {
        submitButton.isEnabled = enabled
    }
    
    func openBoxStateViewController() {
        guard let userVM = GlobalManager.instance.userManager.userViewModel, let boxId = userVM.boxId,
            let threshold = userVM.boxBaseline,
            let currentWeight = userVM.currentWeight
        else {
            Logger.instance.logEvent(type: .login, info: "openBoxStateVC failed because of an empty userVM")
            return
        }
        let boxStateStoryboard = UIStoryboard(name: StoryBoards.boxState, bundle: nil)
        let boxStateVC = boxStateStoryboard.instantiateViewController(withIdentifier: StoryBoards.boxState) as! BoxStateViewController
        let boxStatePresenter = BoxStatePresenter(viewModel: BoxStateViewModel(boxID: boxId, currentWeight: currentWeight, threshold: threshold), view: boxStateVC)
        boxStateVC.presenter = boxStatePresenter
        navigationController?.pushViewController(boxStateVC, animated: true)
    }
    
}

extension SettingsViewController: SettingsViewControllerProtocol {
    func update(viewModel: SettingsViewModel) {
        //titles:
        boxIdLabel.text = viewModel.boxIdTitleText
        thresholdLabel.text = viewModel.ThresholdTitleText
        currentWeightLabel.text = viewModel.currentWeightTitleText
        ebayLinkLabel.text = viewModel.productLinkTitleText
        submitButton.titleLabel?.text = viewModel.submitButtonText
        
        //values:
        boxIdTextBox.text = String(viewModel.boxId)
        if let threshold = viewModel.threshold {
            thresholdTextBox.text = String(threshold)
        } else {
            thresholdTextBox.text = ""
        }
        ebayLinkTextBox.text = viewModel.productLink
        currentWeightTextBox.text = String(viewModel.currentWeight)
    }
}

extension String {
    init?(_ value: Int?) {
        guard let value = value else { return nil }
        self.init(value)
    }
    
    init?(_ value: Double?) {
        guard let value = value else { return nil }
        self.init(value)
    }
}
