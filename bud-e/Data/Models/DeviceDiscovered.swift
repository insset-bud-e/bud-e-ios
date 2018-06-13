//
//  DeviceDiscovered.swift
//  bud-e
//
//  Created by Pierre Joube on 13/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation

class DeviceDiscovered {
    let host: String?
    let hostname: String?
    let port: Int?
    
    init(payload: [String: Any]) {
        if let host = payload["host"] as? String {
            self.host = host
        }
        else {
            self.host = "Unknow"
        }
        
        if let hostname = payload["hostname"] as? String {
            self.hostname = hostname
        }
        else {
            self.hostname = "Unknow"
        }
        
        if let port = payload["port"] as? Int {
            self.port = port
        }
        else {
            self.port = 0
        }
    }
}
