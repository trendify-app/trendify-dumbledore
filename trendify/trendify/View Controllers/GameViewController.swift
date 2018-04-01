//
//  GameViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-04-01.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit
import TextFieldEffects

class GameViewController: UIViewController, UITextFieldDelegate, WebSocketDelegate {
    
    @IBOutlet weak var prefixTextField: IsaoTextField!
    @IBOutlet weak var postfixTextField: IsaoTextField!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var waitingLabel: UILabel!
    
    var trendyWord: String!
    var aPass: String!
    var currentState: String?
    
    let socketManager = WebSocketManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prefixTextField.delegate = self
        postfixTextField.delegate = self
        socketManager.delegate = self
        wordLabel.text = trendyWord
        waitingLabel.isHidden = true
    }
    
    //MARK: - Text Fields Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 12
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            postfixTextField.text = nil
        } else {
            prefixTextField.text = nil
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        var query: String = ""
        if let text = prefixTextField.text, text.count > 0 {
            query = "\(text) \(trendyWord!)"
        } else if let text = postfixTextField.text, text.count > 0 {
            query = "\(trendyWord!) \(text)"
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill out one text field", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        print(query)
        
        socketManager.vote(query: query, accessPass: aPass)
        prefixTextField.isEnabled = false
        postfixTextField.isEnabled = false
        submitButton.isEnabled = false
        waitingLabel.isHidden = false
        
    }
    
    func didEnrollUser() {
        
    }
    
    func newUserList(users: [Player]) {
        
    }
    
    func newRound(number: Int) {
        
    }
    
    func stateDidChange(state: String) {
        self.currentState = state
    }
    
    func newChallengeWord(word: String) {
        
    }
}
