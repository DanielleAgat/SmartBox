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
    
    
    @IBAction func usernameTextBoxEdited(_ sender: UITextField) {
        if !sender.state.isEmpty {
            sender.textColor = .black
        }
    }
    
    @IBAction func passwordTextBoxEdited(_ sender: UITextField) {
        if !sender.state.isEmpty {
            sender.textColor = .black
        }
    }
    
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
        
        let settingsVC = SettingsViewController()
        let presenterSettings = SettingsPresenter(with: settingsVC)
        settingsVC.presenter = presenterSettings
        navigationController?.pushViewController(settingsVC, animated: true)
//        self.present(settingsVC, animated: true, completion: nil)
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
