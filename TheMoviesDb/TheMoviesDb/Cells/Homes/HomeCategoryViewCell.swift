//
//  HomeCategoryViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeCategoryViewCell: UICollectionViewCell {
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "img_mock_category")
        self.addSubview(img)
        return img
    }()
    
    private lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 16)
        labelTitle.textColor = .white
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 1
        labelTitle.text = "Discover"
        self.addSubview(labelTitle)
        return labelTitle
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
        
        self.title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.imgBg.normalShadow()
    }
    
}
