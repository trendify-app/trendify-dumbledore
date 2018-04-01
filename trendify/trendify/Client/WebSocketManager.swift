//
//  WebSocketManager.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

protocol WebSocketDelegate: class {
    func didEnrollUser()
    func newUserList(users: [Player])
    func newRound(number: Int)
    func stateDidChange(state: String)
    func newChallengeWord(word: String)
}

class WebSocketManager {
    
    static let url = URL(string: "http://localhost:8080")!
    static let manager = SocketManager(socketURL: url)
    let socket = manager.defaultSocket
    
    var delegate: WebSocketDelegate?
    
    func connectToWS(accessPass: String, nickname: String) {
        socket.connect()
        
        socket.on("connect") { (data, ack) in
            print("connected")
            self.handshake(accessPass: accessPass, nickname: nickname)
        }
    }
    
    func handshake(accessPass: String, nickname: String) {
        socket.emit("handshake", accessPass)
        
        socket.on("entry-success") { (data, ack) in
            print("Handshake established")
            
            self.enroll(nickname: nickname, accessPass: accessPass)
        }
    }
    
    func enroll(nickname: String, accessPass: String) {
        socket.emit("enroll", accessPass, nickname)
        self.listenForUpdate()
        delegate?.didEnrollUser()
    }
    
    func vote(query: String, accessPass: String) {
        socket.emit("vote", accessPass, query)
    }
    
    func listenForUpdate() {
        socket.on("update") { (data, ack) in
            print("update found")
            let json = JSON(data)
            print(json)
            for subJson in json {
                if subJson.1["type"].stringValue == "users" {
                    var users = [Player]()
                    for user in subJson.1["users"] {
                        let nname = user.1["name"].stringValue
                        if user.1["score"].exists() {
                            let player = Player(name: nname, vote: user.1["vote"].stringValue, score: user.1["score"].intValue)
                            users.append(player)
                        } else {
                            let player = Player(name: nname, vote: nil, score: nil)
                            users.append(player)
                        }
                    }
                    self.delegate?.newUserList(users: users)
                } else if subJson.1["type"].stringValue == "round_number" {
                    self.delegate?.newRound(number: subJson.1["round_number"].intValue)
                } else if subJson.1["type"].stringValue == "state" {
                    self.delegate?.stateDidChange(state: subJson.1["state"].stringValue)
                } else if subJson.1["type"].stringValue == "challenge" {
                    let word = subJson.1["word"].stringValue
                    self.delegate?.newChallengeWord(word: word)
                }
            }
        }
    }
    
}
