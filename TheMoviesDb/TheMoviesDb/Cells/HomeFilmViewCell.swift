//
//  HomeFilmViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeFilmViewCell: UICollectionViewCell {
    
    public lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "img_mock_toprated")
        self.addSubview(img)
        return img
    }()
    
    public lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica, size: 15)
        labelTitle.textColor = UIColor(red: 0.243, green: 0.29, blue: 0.349, alpha: 1)
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        labelTitle.text = "Beauty and \nthe Beast"
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
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(210)
        }
        
        self.title.snp.makeConstraints {
            $0.top.equalTo(self.imgBg.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(40)
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
        }
    }
    
}
