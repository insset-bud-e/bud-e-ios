//
//  DeviceDiscoveredSource.swift
//  bud-e
//
//  Created by Pierre Joube on 13/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation

protocol DeviceDiscoveredSourceDelegate: class {
    func didFetch(devices: [DeviceDiscovered])
    func didSaveDevicesDiscovered(message: String)
}

class DeviceDiscoveredSource {
    let hostUrl = "http://172.20.10.6:5000/"
    //let hostUrl = "https://bud-e-server.herokuapp.com/"
    
    weak var delegate: DeviceDiscoveredSourceDelegate?
    
    func getDevicesDiscovered() -> Void {
        guard let url = URLComponents(string: hostUrl) else {
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
                    if let buffer = json["interfaces"] as? [[String: Any]] {
                        var devices = [DeviceDiscovered]()
                        buffer.forEach { device in
                            devices.append(DeviceDiscovered(payload: device))
                        }
                        self?.delegate?.didFetch(devices: devices)
                    }
                }
            }
        }
        
        downloadTask.resume()
    }
    
    func saveDevicesDiscovered(devices: [Dictionary<String, Any>]) -> Void {
        guard let url = URLComponents(string: hostUrl + "device/save") else {
            assertionFailure()
            return
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let jsonArray = ["devices": devices]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonArray)
        let jsonStr = String(data: jsonData!, encoding: String.Encoding.utf8)
        let postStr = jsonStr!.replacingOccurrences(of: "\\", with: "")
        
        request.httpBody = postStr.data(using: .utf8)
        
        let downloadTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                let rawJSON = try? JSONSerialization.jsonObject(with: data)
                let json = rawJSON as? [String: Any]
                
                if let json = json {
                    if let message = json["message"] as? String {
                        self?.delegate?.didSaveDevicesDiscovered(message: message)
                    }
                }
            }
        }
        
        downloadTask.resume()
    }
}
