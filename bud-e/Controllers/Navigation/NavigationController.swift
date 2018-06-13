//
//  NavigationController.swift
//  bud-e
//
//  Created by Pierre Joube on 13/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //#282828
        self.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        //#3EC273
        //NSAttributedStringKey.font: UIFont
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(red: 62/255, green: 194/255, blue: 115/255, alpha: 1), NSAttributedStringKey.font: UIFont(name: "Montserrat-Bold", size: 18) ?? UIFont.boldSystemFont(ofSize: 18)]
        //#3EC273
        self.navigationBar.tintColor = UIColor(red: 62/255, green: 194/255, blue: 115/255, alpha: 1)
    }
}
