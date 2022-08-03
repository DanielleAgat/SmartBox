//
//  MainViewController.swift
//  SmartBox
//
//  Created by Agat Levi on 11/05/2022.
//

import UIKit

class MainViewController: UIViewController {
    let presenter: MainPresenter = MainPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.checkIfAlreadyLoggedIn()
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        presenter.signup()
    }
    
    
    func openSignupViewController() {
        let signupStoryboard = UIStoryboard(name: StoryBoards.signup, bundle: nil)
        let signupVC = signupStoryboard.instantiateViewController(withIdentifier: StoryBoards.signup) as! SignupViewController
        let signupPresenter = SignupPresenter(viewModel: SignupViewModel(),view: signupVC, manager: GlobalManager.instance.loginManager)
        signupVC.presenter = signupPresenter
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func openBoxStateViewController() {
        guard let userVM = GlobalManager.instance.userManager.userViewModel,
                let boxId = userVM.boxId,
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


