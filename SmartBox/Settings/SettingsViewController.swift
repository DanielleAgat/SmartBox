//
//  SettingsViewController.swift
//  SmartBox
//
//  Created by agat levi on 12/03/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }

}
