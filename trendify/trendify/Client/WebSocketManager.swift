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
    func newUserList(users: [String])
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
    
    func listenForUpdate() {
        socket.on("update") { (data, ack) in
            print("update found")
            let json = JSON(data)
            for subJson in json {
                if subJson.1["type"].stringValue == "users" {
                    var users = [String]()
                    for name in subJson.1["users"] {
                        users.append(name.1["name"].stringValue)
                    }
                    self.delegate?.newUserList(users: users)
                } else if subJson.1["type"].stringValue == "round-number" {
                    print(subJson.1)
                }
            }
        }
    }
    
}
