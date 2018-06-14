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
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deleteDeviceButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(onDeleteDevicePressed))
        deleteDeviceButton.tintColor = UIColor(red: 62/255, green: 194/255, blue: 115/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = deleteDeviceButton
        
        deviceSource.delegate = self
        if let deviceID = deviceID {
            deviceSource.getDevice(deviceID: deviceID)
        }
    }
    
    @objc func onDeleteDevicePressed() {
        if let deviceID = deviceID {
            deviceSource.deleteDevice(deviceID: deviceID)
        }
    }
    
    func didFetch(device: Device) {
        DispatchQueue.main.sync {
            self.device = device
            refreshUI()
        }
    }
    
    func didDeviceDeleted(message: String) {
        DispatchQueue.main.sync {
            if message == "Device forgotten." {
                nc.post(name: Notification.Name(rawValue: "deviceDeleted"), object: nil, userInfo: ["id": self.deviceID ?? "-1"])
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func refreshUI() {
        if let name = device?.name {
            self.title = name
        }
        
        if let ipAddress = device?.ipAddress {
            self.ipAddressLabel.text = "Adresse IP: " + ipAddress
        }
        else {
            self.ipAddressLabel.text = "Adresse IP: unknow"
        }
        
        if let type = device?.type {
            self.typeLabel.text = "Type: " + type
        }
        else {
            self.typeLabel.text = "Type: unknow"
        }
    }
}
