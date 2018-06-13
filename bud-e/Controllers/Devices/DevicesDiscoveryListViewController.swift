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
    var pullToRefreshControl: UIRefreshControl!
    
    var devices: [DeviceDiscovered]?
    let deviceSource = DeviceDiscoveredSource()
    
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
        deviceSource.getDevicesDiscovered()
        spinner.startAnimating()
    }
    
    @objc func pullToRefresh() {
        deviceSource.getDevicesDiscovered()
    }
    
    func didFetch(devices: [DeviceDiscovered]) {
        DispatchQueue.main.async {
            self.devices = devices
            self.devicesCollection.reloadData()
            
            if self.spinner.isAnimating {
                self.spinner.stopAnimating()
            }
            
            if self.pullToRefreshControl.isRefreshing {
                self.pullToRefreshControl.endRefreshing()
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
}
