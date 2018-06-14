//
//  DevicesListViewController.swift
//  bud-e
//
//  Created by Pierre Joube on 11/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation
import UIKit

class DevicesListViewController: UIViewController, DeviceSourceDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var devicesCollection: UICollectionView!
    @IBOutlet weak var noDevicesLabel: UILabel!
    var pullToRefreshControl: UIRefreshControl!
    
    var devices: [Device]?
    let deviceSource = DeviceSource()
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devicesCollection.clipsToBounds = false
        devicesCollection.layer.masksToBounds = false
        
        devicesCollection.alwaysBounceVertical = true
        pullToRefreshControl = UIRefreshControl()
        pullToRefreshControl.tintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        pullToRefreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        devicesCollection.addSubview(pullToRefreshControl)
        
        deviceSource.delegate = self
        deviceSource.getDevices()
        
        nc.addObserver(self, selector: #selector(deleteDevice), name: Notification.Name(rawValue: "deviceDeleted"), object: nil)
    }
    
    @objc func pullToRefresh() {
        self.noDevicesLabel.isHidden = true
        deviceSource.getDevices()
    }
    
    @objc func deleteDevice(notification: Notification) {
        if self.devices != nil {
            for (index, element) in self.devices!.enumerated().reversed() {
                if let id = element.id {
                    let userInfo:Dictionary<String,String> = notification.userInfo as! Dictionary<String,String>
                    let idToDelete = userInfo["id"]! as String
                    if (id == idToDelete) {
                        self.devices?.remove(at: index)
                        self.devicesCollection.reloadData()
                    }
                }
            }
            if (self.devices?.count)! > 0 {
                self.noDevicesLabel.isHidden = true
            }
            else {
                self.noDevicesLabel.isHidden = false
            }
        }
    }
    
    func didFetchAll(devices: [Device]) {
        DispatchQueue.main.sync {
            if pullToRefreshControl.isRefreshing {
                pullToRefreshControl.endRefreshing()
            }
            
            if devices.count > 0 {
                self.devices = devices
                self.devicesCollection.reloadData()
                self.noDevicesLabel.isHidden = true
            }
            else {
                self.noDevicesLabel.isHidden = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let device = devices?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCell", for: indexPath)
        let deviceNameLabel = cell.viewWithTag(1) as? UILabel
        
        deviceNameLabel?.text = device?.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*
         -10: margin left
         -10: margin right
         -10: inner margin
        */
        let size = CGSize(width: (UIScreen.main.bounds.width - 10 - 10 - 10) / 2, height: 100)
        
        return size
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeviceDetails" {
            if let cell = sender as? UICollectionViewCell {
                if let indexPath = devicesCollection.indexPath(for: cell) {
                    let backItem = UIBarButtonItem()
                    let device = devices?[indexPath.row]
                    let destination = segue.destination as? DeviceDetailViewController
                    
                    backItem.title = ""
                    navigationItem.backBarButtonItem = backItem
                    
                    destination?.deviceID = device?.id
                }
            }
        }
    }
}
