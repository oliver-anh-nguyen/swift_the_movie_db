//
//  DetailRatingViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Cosmos

class DetailRatingViewCell: UICollectionViewCell {
    
    public var cosmosView: CosmosView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.cosmosView = CosmosView()
        self.cosmosView.settings.fillMode = .full
        self.cosmosView.settings.starSize = 35
        self.cosmosView.settings.starMargin = 15
        self.cosmosView.rating = 0
        self.cosmosView.settings.emptyImage = UIImage(named: image_detail_ic_star_empty)
        self.cosmosView.settings.filledImage = UIImage(named: image_detail_ic_star_full)
        self.addSubview(self.cosmosView)
        self.cosmosView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(235)
            $0.height.equalTo(40)
        }
        self.cosmosView.didFinishTouchingCosmos = { rating in
            print(rating)
        }
    }
}
