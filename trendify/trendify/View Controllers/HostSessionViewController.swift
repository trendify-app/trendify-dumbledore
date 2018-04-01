//
//  HostSessionViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit
import TextFieldEffects

class HostSessionViewController: UIViewController {

    @IBOutlet weak var nnameTextField: IsaoTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    @IBAction func hostButtonTapped(_ sender: UIButton) {
        if let text = nnameTextField.text, text.count > 0 {
            
        }
    }
}
