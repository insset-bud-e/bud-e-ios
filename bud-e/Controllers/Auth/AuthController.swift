//
//  AuthController.swift
//  bud-e
//
//  Created by Pierre Joube on 14/03/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import UIKit

class AuthController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func processLogin(_ sender: Any) {
        if let username = username.text {
            if let password = password.text {
                if !username.isEmpty && !password.isEmpty {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
