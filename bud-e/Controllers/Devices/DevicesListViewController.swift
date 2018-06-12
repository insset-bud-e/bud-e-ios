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
    
    var devices: [Device]?
    let deviceSource = DeviceSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceSource.delegate = self
        deviceSource.getDevices()
    }
    
    func didFetch(devices: [Device]) {
        DispatchQueue.main.sync {
            self.devices = devices
            self.devicesCollection.reloadData()
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
}
