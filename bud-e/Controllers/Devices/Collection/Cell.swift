//
//  Cell.swift
//  bud-e
//
//  Created by Pierre Joube on 13/06/2018.
//  Copyright © 2018 Pierre Joube. All rights reserved.
//

import Foundation
import UIKit

class CollectionCellController: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1).cgColor
    }
}
