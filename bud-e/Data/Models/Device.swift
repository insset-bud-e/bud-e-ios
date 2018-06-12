
//
//  Device.swift
//  bud-e
//
//  Created by Pierre Joube on 11/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation

class Device {
    let id: String?
    let name: String?
    let ipAddress: String?
    let type: String?
    
    init(payload: [String: Any]) {
        if let id = payload["_id"] as? String {
            self.id = id
        }
        else {
            self.id = "Unknow"
        }
        
        if let name = payload["name"] as? String {
            self.name = name
        }
        else {
            self.name = "Unknow"
        }
        
        if let ip = payload["ip"] as? String {
            self.ipAddress = ip
        }
        else {
            self.ipAddress = "0.0.0.0"
        }
        
        if let type = payload["type"] as? String {
            self.type = type
        }
        else {
            self.type = "Unknow"
        }
    }
}
