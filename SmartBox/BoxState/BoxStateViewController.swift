//
//  BoxStateViewController.swift
//  SmartBox
//
//  Created by Agat Levi on 07/05/2022.
//

import UIKit

class BoxStateViewController: UIViewController {
    @IBOutlet var boxStateInfo: UILabel!
    @IBOutlet var boxIdInfo: UILabel!
    @IBOutlet var boxThresholdInfo: UILabel!
    
    var presenter: BoxStatePresenter!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.logoutMenuItem, style: .plain, target: self, action: #selector(logoutTapped))
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = nil
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    
    @objc func logoutTapped() {
        presenter.logout()
    }
    
    func openMainScreen() {
        navigationController?.popToRootViewController(animated: true)
    }

}

extension BoxStateViewController {
    func update(viewModel: BoxStateViewModel) {
        boxThresholdInfo.text = String(viewModel.threshold) + "%"
        boxStateInfo.text = String(viewModel.currentWeight)
        boxIdInfo.text = String(viewModel.boxID)
        view.layoutIfNeeded()
    }
}
