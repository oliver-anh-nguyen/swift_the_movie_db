//
//  DetailSeriesCastCollectionCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class DetailSeriesCastCollectionCell: BaseCollectionCell {
    
    override func sizeCollection() -> CGSize {
        return size_detail_series
    }
    
    override func registerCell() {
        self.collectionView.register(DetailSeriesCastViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension DetailSeriesCastCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailSeriesCastViewCell.self), for: indexPath) as? DetailSeriesCastViewCell else {
            fatalError()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension DetailSeriesCastCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: marginCell, bottom: 0, right: marginCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}
