//
//  DeviceDetailsViewController.swift
//  bud-e
//
//  Created by Pierre Joube on 12/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation
import UIKit

class DeviceDetailViewController: UIViewController, DeviceSourceDelegate {
    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var deviceID: String?
    var device: Device?
    let deviceSource = DeviceSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceSource.delegate = self
        if let deviceID = deviceID {
            deviceSource.getDevice(deviceID: deviceID)
        }
    }
    
    func didFetch(device: Device) {
        DispatchQueue.main.sync {
            self.device = device
            
            self.title = device.name
            self.ipAddressLabel.text = "Adresse IP : " + device.ipAddress!
            self.typeLabel.text = "Type : " + device.type!
        }
    }
}
