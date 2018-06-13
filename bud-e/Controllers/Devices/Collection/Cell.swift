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
