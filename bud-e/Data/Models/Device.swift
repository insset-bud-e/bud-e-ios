
//
//  Device.swift
//  bud-e
//
//  Created by Pierre Joube on 11/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation

class Device {
    let id: Int?
    let name: String?
    let ipAddress: String?
    
    init(payload: [String: Any]) {
        if let data = payload["data"] as? [String: Any] {
            id = Int(data["id"] as! String)
            name = String(data["name"] as! String)
            ipAddress = String(data["ipAddress"] as! String)
        }
        else {
            id = 0
            name = "Unknow"
            ipAddress = "0.0.0.0"
        }
    }
}
