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

//    var authenticatorError: AuthenticationErrorProtocol
    lazy var presenter = LoginPresenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        authenticatorError.delegate += self
        loadingAnimation.stopAnimating()
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
        guard let password = passwordTextBox.text else { return }
        guard let username = userNameTextBox.text else { return }
        presenter.send(username: username, password: password)
        
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsVC = settingsStoryboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        let presenterSettings = SettingsPresenter(with: settingsVC)
        settingsVC.presenter = presenterSettings
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension LoginViewController: AuthenticationErrorDelegate {
    func userNameAuthenticationError(title: String, description: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

//extension LoginViewController: PresenterView {
//    func update(viewModel: LoginViewModel) {
//       changeTextLabel.text = "I have been changed!"
//       self.view.backgroundColor = .yellow
//    }
//}

