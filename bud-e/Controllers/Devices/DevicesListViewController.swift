//
//  DevicesListViewController.swift
//  bud-e
//
//  Created by Pierre Joube on 11/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation
import UIKit

class DevicesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var devicesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell") ?? UITableViewCell(style: .default, reuseIdentifier: "deviceCell")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
