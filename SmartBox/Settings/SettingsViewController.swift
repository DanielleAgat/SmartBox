//
//  SettingsViewController.swift
//  SmartBox
//
//  Created by Agat Levi on 09/04/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    enum titles {
        static let accountDisconnected = "Connect to eBay account"
        static let isConnected = " is connected"
    }

    var presenter: SettingsPresenter!
    var ebayUserName: String?

    @IBOutlet var ebayAccountButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var boxIdTextBox: UITextField!
    @IBOutlet var thresholdTextBox: UITextField!
    @IBOutlet var ebayLinkTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(self)
        presenter.setSubmitAvailability()
        ebayAccountButton.setTitle(presenter.setAccountButtonText(), for: .normal)
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
    
    @IBAction func ebayLinkTextBoxEdited(_ sender: UITextField) {
        presenter.setSubmitAvailability()
    }
    
    
    @IBAction func ebayAcoountButtonTapped(_ sender: UIButton) {
        ebayUserName = presenter.connectToEbayAccount()
        sender.setTitle(presenter.setAccountButtonText(), for: .normal)
        presenter.setSubmitAvailability()
    }
    
    func setSubmitButton(enabled: Bool) {
        submitButton.isEnabled = enabled
    }
}
