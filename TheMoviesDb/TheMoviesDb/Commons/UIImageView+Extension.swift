//
//  UIImageView+Extension.swift
//  TheMoviesDb
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func normalShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:2)
    }
  
}
