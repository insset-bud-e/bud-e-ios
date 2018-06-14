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
    func didDeviceDeleted(message: String)
}

extension DeviceSourceDelegate {
    func didFetchAll(devices: [Device]) {}
    func didFetch(device: Device) {}
    func didDeviceDeleted(message: String) {}
}

class DeviceSource {
    let hostUrl = "http://172.20.10.6:5000/"
    //let hostUrl = "https://bud-e-server.herokuapp.com/"
    
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
    
    func deleteDevice(deviceID: String) -> Void {
        guard let url = URLComponents(string: hostUrl + "device/remove/" + deviceID) else {
            assertionFailure()
            return
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "POST"
        
        let downloadTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                let rawJSON = try? JSONSerialization.jsonObject(with: data)
                let json = rawJSON as? [String: Any]
                
                if let json = json {
                    if let message = json["message"] as? String {
                        self?.delegate?.didDeviceDeleted(message: message)
                    }
                }
            }
        }
        
        downloadTask.resume()
    }
}
