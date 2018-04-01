//
//  JoinSessionViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyJSON

class JoinSessionViewController: UIViewController, UITextFieldDelegate, WebSocketDelegate {
    
    @IBOutlet weak var nicknameTextField: IsaoTextField!
    @IBOutlet weak var roomNumberTextField: IsaoTextField!
    @IBOutlet weak var joinSessionButton: UIButton!
    
    let socketManager = WebSocketManager()
    var aPass: String!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        roomNumberTextField.delegate = self
        joinSessionButton.layer.cornerRadius = 4
        
        socketManager.delegate = self
    }
    
    //MARK: - Text Fields Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 4
    }
    
    //MARK: - Event Handlers
    @IBAction func joinSessionButtonTapped(_ sender: UIButton) {
        if let nname = nicknameTextField.text, let rID = roomNumberTextField.text {
            let fetcher = APIFetcher()
            fetcher.joinSession(roomID: rID, completion: { (json) in
                guard let json = json else {
                    let alert = UIAlertController(title: "Error", message: "No session found with provided ID", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                self.aPass = json["access_pass"].stringValue
                self.socketManager.connectToWS(accessPass: self.aPass, nickname: nname)
            })
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill all text fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Web Socket Delegate
    func didEnrollUser() {
        let lobbyVC = self.storyboard?.instantiateViewController(withIdentifier: "lobbyVC") as! LobbyViewController
        lobbyVC.lobbyCode = roomNumberTextField.text
        lobbyVC.userNName = nicknameTextField.text
        lobbyVC.aPass = aPass
        lobbyVC.socketManager.delegate = lobbyVC
        self.navigationController?.pushViewController(lobbyVC, animated: true)
    }
    
    func newUserList(users: [String]) {
        
    }
    
    func newRound(number: Int) {
        
    }
    
    func stateDidChange(state: String) {
         
    }
    
    func newChallengeWord(word: String) {
         
    }
}
