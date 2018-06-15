//
//  DevicesDiscoveryListViewController.swift
//  bud-e
//
//  Created by Pierre Joube on 13/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation
import UIKit

class DevicesDiscoveryListViewController: UIViewController, DeviceDiscoveredSourceDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var devicesCollection: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var noDevicesLabel: UILabel!
    var pullToRefreshControl: UIRefreshControl!
    
    var devices: [DeviceDiscovered]?
    let deviceDiscoveredSource = DeviceDiscoveredSource()
    var deviceSelected: [IndexPath]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addDevicesButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddDevicesPressed))
        addDevicesButton.isEnabled = false
        //#3EC273
        addDevicesButton.tintColor = UIColor(red: 62/255, green: 194/255, blue: 115/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = addDevicesButton
        
        devicesCollection.clipsToBounds = false
        devicesCollection.layer.masksToBounds = false
        devicesCollection.allowsMultipleSelection = true
        
        devicesCollection.alwaysBounceVertical = true
        pullToRefreshControl = UIRefreshControl()
        pullToRefreshControl.tintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        pullToRefreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        devicesCollection.addSubview(pullToRefreshControl)
        
        deviceDiscoveredSource.delegate = self
        deviceDiscoveredSource.getDevicesDiscovered()
        spinner.startAnimating()
    }
    
    @objc func pullToRefresh() {
        self.noDevicesLabel.isHidden = true
        deviceDiscoveredSource.getDevicesDiscovered()
    }
    
    @objc func onAddDevicesPressed() {
        spinner.startAnimating()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        var devicesBuffer = [Dictionary<String, Any>]()
        self.deviceSelected?.forEach { deviceIndex in
            let deviceToAdd = self.devices?[deviceIndex.row]
            devicesBuffer.append(["ip": deviceToAdd?.host ?? "Unknow", "hostname": deviceToAdd?.hostname ?? "Unknow", "port": deviceToAdd?.port ?? 0])
        }
        
        self.deviceDiscoveredSource.saveDevicesDiscovered(devices: devicesBuffer)
    }
    
    func didFetch(devices: [DeviceDiscovered]) {
        DispatchQueue.main.async {
            if self.spinner.isAnimating {
                self.spinner.stopAnimating()
            }
            
            if self.pullToRefreshControl.isRefreshing {
                self.pullToRefreshControl.endRefreshing()
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
    
    func didSaveDevicesDiscovered(message: String) {
        DispatchQueue.main.async {
            if self.spinner.isAnimating {
                self.spinner.stopAnimating()
            }
            if (message == "Devices added successfully.") {
                self.deviceSelected?.forEach { deviceIndex in
                    self.devices?.remove(at: deviceIndex.row)
                }
                self.deviceSelected = []
                self.devicesCollection.reloadData()
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
        
        deviceNameLabel?.text = device?.hostname
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.deviceSelected = collectionView.indexPathsForSelectedItems;
        
        if (self.deviceSelected?.count)! > 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.deviceSelected = collectionView.indexPathsForSelectedItems;
        
        if (self.deviceSelected?.count)! > 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
