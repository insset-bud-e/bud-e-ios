//
//  TabsController.swift
//  bud-e
//
//  Created by Pierre Joube on 14/03/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import UIKit

class TabsController: UITabBarController {    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.bool(forKey: "isLogged") {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }
}
