//
//  SignupViewController.swift
//  SmartBox
//
//  Created by Agat Levi on 11/05/2022.
//

import UIKit

class SignupViewController: UIViewController {
    var presenter: SignupPresenter!

    @IBOutlet var loadinAnimation: UIActivityIndicatorView!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var passwordTextbox: UITextField!
    @IBOutlet var usernameTextbox: UITextField!
    @IBOutlet var passwordInvalid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadinAnimation.stopAnimating()
        signupButton.isHidden = false
        presenter.attachView(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        loadinAnimation.startAnimating()
        signupButton.isHidden = true
        
        guard let password = validatePassword(field: passwordTextbox) else {
            passwordInvalid.isHidden = false
            loadinAnimation.stopAnimating()
            signupButton.isHidden = false
            return
        }
        passwordInvalid.isHidden = true
        guard let username = usernameTextbox.text else { return }
        if !username.isValidEmail() {
            let okAction = UIAlertAction(title: Strings.letMeFixItButton, style: .default, handler: nil)
            showAlertViewController(title: Strings.invalidInput, message: Strings.invalidEmailMessage, actions: [okAction], animated: true, completion: {
                self.loadinAnimation.stopAnimating()
                self.signupButton.isHidden = false
            })
            return
        }
        
        presenter.signup(username: username, password: password)
    }
    
    func validatePassword(field: UITextField) -> String? {
        guard let text:String = field.text else {
            return nil
        }
        /*6-16 charaters, and at least one number*/
        let RegEx = "^(?=.*\\d)(.+){6,16}$"
        let Test = NSPredicate(format:"SELF MATCHES%@", RegEx)
        let isValid = Test.evaluate(with: text)

        if (isValid) {
            return text
        }

        return nil
    }
    
    func openSettingsViewController(){
        let settingsStoryboard = UIStoryboard(name: StoryBoards.settings, bundle: nil)
        let settingsVC = settingsStoryboard.instantiateViewController(withIdentifier: StoryBoards.settings) as! SettingsViewController
        let presenterSettings = SettingsPresenter(with: settingsVC, settingsManager: GlobalManager.instance.settingsManager)
        settingsVC.presenter = presenterSettings
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func showSignupFailedAlert(error: String) {
        let okAction = UIAlertAction(title: Strings.popUpConfirmation, style: .default, handler: nil)
        showAlertViewController(title: Strings.signupFailedTitle, message: error, actions: [okAction], animated: true, completion: {
            self.loadinAnimation.stopAnimating()
            self.signupButton.isHidden = false
        })
        return
    }

}

extension SignupViewController {
    func update(viewModel: SignupViewModel) {
        //TODO:
    }
}
