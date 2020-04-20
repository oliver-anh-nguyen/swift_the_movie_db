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
    
    private lazy var cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .full
        cosmosView.settings.starSize = 30
        cosmosView.settings.starMargin = 15
        cosmosView.rating = 0
        cosmosView.settings.emptyImage = UIImage(named: image_detail_ic_star_empty)
        cosmosView.settings.filledImage = UIImage(named: image_detail_ic_star_full)
        self.addSubview(cosmosView)
        return cosmosView
    }()
    
    private lazy var lblRating: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 22)
        labelTitle.textColor = UIColor(red: 0.608, green: 0.608, blue: 0.608, alpha: 1)
        labelTitle.textAlignment = .center
        labelTitle.text = "0.0"
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    private lazy var btnComment: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(str_detail_button_comment, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: font_helvetica_bold, size: 14)
        btn.backgroundColor = UIColor(red: 0, green: 0.478, blue: 0.851, alpha: 1)
        btn.layer.cornerRadius = imgCornerRadius
        self.addSubview(btn)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.cosmosView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(210)
            $0.height.equalTo(30)
        }
        
        self.cosmosView.didFinishTouchingCosmos = { rating in
            self.lblRating.text = "\(rating)"
            self.lblRating.textColor = UIColor(red: 0.945, green: 0.792, blue: 0.137, alpha: 1)
        }
        
        self.lblRating.snp.makeConstraints {
            $0.top.equalTo(self.cosmosView.snp.bottom).offset(8)
            $0.height.equalTo(30)
            $0.centerX.equalTo(self.cosmosView)
        }
        
        self.btnComment.snp.makeConstraints {
            $0.top.equalTo(self.lblRating.snp.bottom).offset(14)
            $0.height.equalTo(34)
            $0.width.equalTo(190)
            $0.centerX.equalTo(self.cosmosView)
        }
    }
}
