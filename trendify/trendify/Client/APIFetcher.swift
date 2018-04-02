//
//  APIFetcher.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIFetcher {
    
    func joinSession(roomID: String, completion: @escaping(_ json: JSON?) -> Void) {
        let url = "http://trendify.tech:8080/api/sessions/join/\(roomID)"
        Alamofire.request(url, method: .put, parameters: nil, encoding: JSONEncoding.default).response { (res) in
            if let data = res.data {
                let json = JSON(data)
                if let vals = json.dictionary, vals.count > 0 {
                    completion(json)
                } else  {
                    completion(nil)
                }
            }
        }
    }
    
    func joinSession(roomID: String, accessToken: String, completion: @escaping(_ json: JSON?) -> Void) {
        let url = "http://trendify.tech:8080/api/sessions/join/\(roomID)"
        let parameters = ["Authorization": accessToken]
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default).response { (res) in
            if let data = res.data {
                let json = JSON(data)
                if let vals = json.dictionary, vals.count > 0 {
                    completion(json)
                } else  {
                    completion(nil)
                }
            }
        }
    }
    
    func createSession(completion: @escaping(_ json: JSON?) -> Void) {
        let url = "http://trendify.tech:8080/api/sessions/create"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default).response { (res) in
            if let data = res.data {
                let json = JSON(data)
                completion(json)
            }
        }
    }
    
}
