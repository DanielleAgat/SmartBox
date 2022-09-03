//
//  LoginViewController.swift
//  SmartBox
//
//  Created by agat levi on 02/03/2022.
//

import UIKit

protocol AuthenticationErrorDelegate {
    func userNameAuthenticationError(title: String, description: String)
}

class LoginViewController: UIViewController {

    lazy var presenter = LoginPresenter(view: self, viewModel: LoginViewModel(), loginManager: GlobalManager.instance.loginManager)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAnimation.stopAnimating()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(self)
        loadingAnimation.stopAnimating()
        loginButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    
    deinit {
//        authenticatorError.delegate -= self
    }

    @IBOutlet var smartBoxLogo: UILabel!
    @IBOutlet var userNameTextBox: UITextField!
    @IBOutlet var passwordTextBox: UITextField!
    @IBOutlet weak var loadingAnimation: UIActivityIndicatorView!
    @IBOutlet var loginButton: UIButton!
    
    func changeLoginButtonAvailability() {
        if !userNameTextBox.state.isEmpty && !passwordTextBox.state.isEmpty {
            //TODO: Change login button to enabled
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loadingAnimation.startAnimating()
        sender.isHidden = true
        guard let password = passwordTextBox.text, let username = userNameTextBox.text?.lowercased() else { return }
        if !username.isValidEmail() {
            let okAction = UIAlertAction(title: Strings.letMeFixItButton, style: .default, handler: nil)
            showAlertViewController(title: Strings.invalidInput, message: Strings.invalidEmailMessage, actions: [okAction], animated: true, completion: {
                self.loadingAnimation.stopAnimating()
                self.loginButton.isHidden = false
            })
            return
        }
        presenter.login(with: username, and: password)
    }
    
    func openSettingsViewController() {
        let settingsStoryboard = UIStoryboard(name: StoryBoards.settings, bundle: nil)
        let settingsVC = settingsStoryboard.instantiateViewController(withIdentifier: StoryBoards.settings) as! SettingsViewController
        let presenterSettings = SettingsPresenter(with: settingsVC, settingsManager: GlobalManager.instance.settingsManager)
        settingsVC.presenter = presenterSettings
        navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    
    func showMissingConfigurationAlert() {
        let okAction = UIAlertAction(title: Strings.popUpConfirmation, style: .default, handler: { [weak self] _ in
            self?.openSettingsViewController()
        })
        showAlertViewController(title: Strings.missingFieldsTitle, message: Strings.missingFieldsMessage, actions: [okAction], animated: true, completion: { [weak self] in
            self?.loadingAnimation.stopAnimating()
        })
    }
    
    func openBoxStateViewController(){
        Logger.instance.logEvent(type: .login, info: "openBoxStateVC triggered")
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
        Logger.instance.logEvent(type: .login, info: "openBoxStateVC: presenter  created!")
        navigationController?.pushViewController(boxStateVC, animated: true)
    }
    
    func showLoginFailedAlert(error: String) {
        let okAction = UIAlertAction(title: Strings.popUpConfirmation, style: .default, handler: nil)
        showAlertViewController(title: Strings.loginFailedTitle, message: error, actions: [okAction], animated: true, completion: {
            self.loadingAnimation.stopAnimating()
            self.loginButton.isHidden = false
        })
        return
    }
}

extension LoginViewController: AuthenticationErrorDelegate {
    func userNameAuthenticationError(title: String, description: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: Strings.popUpConfirmation, style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension LoginViewController: LoginPresenterView {
    func update(viewModel: LoginViewModel) {

    }
}

