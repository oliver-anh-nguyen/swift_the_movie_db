//
//  DetailSeriesCastViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class DetailSeriesCastViewCell: UICollectionViewCell {
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "detail_mock_series")
        self.addSubview(img)
        return img
    }()
    
    private lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 12)
        labelTitle.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        labelTitle.textAlignment = .justified
        labelTitle.numberOfLines = 1
        labelTitle.text = "Zack Snyder"
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    private lazy var desc: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font_helvetica, size: 12)
        label.textColor = UIColor(red: 0.608, green: 0.608, blue: 0.608, alpha: 1)
        label.textAlignment = .justified
        label.numberOfLines = 1
        label.text = "Director"
        self.addSubview(label)
        return label
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
            $0.centerX.equalToSuperview()
            $0.width.equalTo(70)
            $0.height.equalTo(102)
            $0.top.equalTo(15)
        }
        
        self.imgBg.normalShadow()
        
        self.title.snp.makeConstraints {
            $0.left.right.equalTo(self.imgBg)
            $0.top.equalTo(self.imgBg.snp.bottom).offset(5)
            $0.height.equalTo(16)
        }
        
        self.desc.snp.makeConstraints {
            $0.left.right.equalTo(self.imgBg)
            $0.top.equalTo(self.title.snp.bottom).offset(2)
            $0.height.equalTo(14)
        }
    }
    
}
