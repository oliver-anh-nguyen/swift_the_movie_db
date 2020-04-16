//
//  UICollectionView+Extension.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    func register<T>(_ cellClass: T.Type, _ collection: UICollectionView) where T: UICollectionViewCell {
        collection.register(cellClass, forCellWithReuseIdentifier: "\(cellClass)")
    }
    
    func registerHeader<T>(_ cellClass: T.Type, _ collection: UICollectionView) where T: UICollectionReusableView {
        collection.register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "\(cellClass)")
    }
    
}
