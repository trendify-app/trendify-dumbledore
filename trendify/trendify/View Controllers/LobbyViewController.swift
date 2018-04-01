//
//  LobbyViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WebSocketDelegate {
    
    @IBOutlet weak var lobbyCodeLabel: UILabel!
    @IBOutlet weak var participantsTableView: UITableView!
    @IBOutlet weak var waitingForHostLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    
    let kReuseIdentifier = "participationCell"
    var lobbyCode: String!
    var userNName: String!
    var accessPass: String?
    var participants: [String]?
    
    var aPass: String!
    
    let socketManager = WebSocketManager()
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        startGameButton.layer.cornerRadius = 4
        waitingForHostLabel.isHidden = true
        
        participantsTableView.delegate = self
        participantsTableView.dataSource = self
        
        
        socketManager.delegate = self
        socketManager.listenForUpdate()
        
        lobbyCodeLabel.text = lobbyCode
        
        participants = [userNName]
        participantsTableView.reloadData()
        
        if accessPass != nil {
            waitingForHostLabel.isHidden = true
            startGameButton.isHidden = false
        } else {
            waitingForHostLabel.isHidden = false
            startGameButton.isHidden = true
        }
    }
    
    //MARK: - Event Handlers
    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.aPass = aPass
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (participants != nil) ? participants!.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier, for: indexPath) as! PlayerTableViewCell
        cell.formatCellForName(name: participants![indexPath.row])
        return cell
    }
    
    //MARK: - Web Socket Delegate Methods
    func didEnrollUser() {
    }
    
    func newUserList(users: [String]) {
        participants = users
        participantsTableView.reloadData()
    }
    
    func newRound(number: Int) {
//        if number == 0 {
//            let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
//            gameVC.aPass = aPass
//            navigationController?.pushViewController(gameVC, animated: true)
//        }
    }
    
    func stateDidChange(state: String) {
        
    }
    
    func newChallengeWord(word: String) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.aPass = aPass
        gameVC.trendyWord = word
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
