//
//  HomeRecommendationsCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeRecommendCollectionCell: BaseCollectionCell {
    
    override func sizeCollection() -> CGSize {
        return size_home_recomendations
    }
    
    override func registerCell() {
        self.collectionView.register(HomeRecommendViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension HomeRecommendCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeRecommendViewCell.self), for: indexPath) as? HomeRecommendViewCell else {
            fatalError()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        UINavigationController.currentActiveNavigationController()?.pushViewController(detailView, animated: true)
    }
    
}

