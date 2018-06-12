//
//  DeviceSource.swift
//  bud-e
//
//  Created by Pierre Joube on 12/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation

protocol DeviceSourceDelegate: class {
    func didFetchAll(devices: [Device])
    func didFetch(device: Device)
}

extension DeviceSourceDelegate {
    func didFetchAll(devices: [Device]) {}
    func didFetch(device: Device) {}
}

class DeviceSource {
    let hostUrl = "https://bud-e-server.herokuapp.com/"
    
    weak var delegate: DeviceSourceDelegate?
    
    func getDevices() -> Void {
        guard let url = URLComponents(string: hostUrl + "devices") else {
            assertionFailure()
            return
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        
        let downloadTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                let rawJSON = try? JSONSerialization.jsonObject(with: data)
                let json = rawJSON as? [String: Any]
                
                if let json = json {
                    if let buffer = json["res"] as? [[String: Any]] {
                        var devices = [Device]()
                        buffer.forEach { device in
                            devices.append(Device(payload: device))
                        }
                        self?.delegate?.didFetchAll(devices: devices)
                    }
                }
            }
        }
        
        downloadTask.resume()
    }
    
    func getDevice(deviceID: String) -> Void {
        guard let url = URLComponents(string: hostUrl + "device/" + deviceID) else {
            assertionFailure()
            return
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        
        let downloadTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                let rawJSON = try? JSONSerialization.jsonObject(with: data)
                let json = rawJSON as? [String: Any]
                
                if let json = json {
                    if let buffer = json["res"] as? [[String: Any]] {
                        let device = Device(payload: buffer[0])
                        self?.delegate?.didFetch(device: device)
                    }
                }
            }
        }
        
        downloadTask.resume()
    }
}
