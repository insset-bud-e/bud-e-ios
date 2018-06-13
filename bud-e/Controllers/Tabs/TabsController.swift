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
        
        //#282828
        self.tabBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        //#3EC273
        self.tabBar.tintColor = UIColor(red: 62/255, green: 194/255, blue: 115/255, alpha: 1)
    }
}
