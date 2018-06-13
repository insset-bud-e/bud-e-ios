//
//  self.swift
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
        
        self.layer.shadowColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width:0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
        self.backgroundColor = UIColor.white
    }
}

class CollectionCellDiscoveredController: CollectionCellController {
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                //#3ec273
                self.backgroundColor = UIColor(red: 62/255, green: 194/255, blue: 115/255, alpha: 1)
            }
            else {
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                //#78d49d
                self.backgroundColor = UIColor(red: 120/255, green: 212/255, blue: 157/255, alpha: 1)
            }
            else {
                //No color
            }
        }
    }
}
