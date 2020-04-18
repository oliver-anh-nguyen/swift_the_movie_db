//
//  HomeRecommendViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import SnapKit

class HomeRecommendViewCell: UICollectionViewCell {
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "img_mock_recommend")
        self.addSubview(img)
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.imgBg.image = UIImage(named: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.imgBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.imgBg.normalShadow()
    }
    
}
