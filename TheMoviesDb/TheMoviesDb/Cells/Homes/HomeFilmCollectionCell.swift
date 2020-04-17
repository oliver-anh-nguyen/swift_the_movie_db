//
//  HomeFilmCollectionCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class HomeFilmCollectionCell: BaseCollectionCell {
    
    override func sizeCollection() -> CGSize {
        return size_home_other
    }
    
    override func registerCell() {
        self.collectionView.register(HomeFilmViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension HomeFilmCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeFilmViewCell.self), for: indexPath) as? HomeFilmViewCell else {
            fatalError()
        }
        cell.detailButton = {
            print(indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


