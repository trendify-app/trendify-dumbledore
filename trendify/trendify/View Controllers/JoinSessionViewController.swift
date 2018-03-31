//
//  JoinSessionViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit
import TextFieldEffects

class JoinSessionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nicknameTextField: IsaoTextField!
    @IBOutlet weak var roomNumberTextField: IsaoTextField!
    @IBOutlet weak var joinSessionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        roomNumberTextField.delegate = self
        joinSessionButton.layer.cornerRadius = 4
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 4
    }
    
    @IBAction func joinSessionButtonTapped(_ sender: UIButton) {
        
    }
    
}
