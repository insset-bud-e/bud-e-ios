//
//  DevicesListViewController.swift
//  bud-e
//
//  Created by Pierre Joube on 11/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation
import UIKit

class DevicesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var devicesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCell", for: indexPath)
        let deviceNameLabel = cell.viewWithTag(1) as? UILabel
        deviceNameLabel?.text = "Mon label"
        
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
