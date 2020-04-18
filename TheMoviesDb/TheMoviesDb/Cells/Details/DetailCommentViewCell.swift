//
//  DetailCommentViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Cosmos

class DetailCommentViewCell: UICollectionViewCell {
    
    private lazy var imgAvatar: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "detail_mockup_comment")
        self.addSubview(img)
        return img
    }()
    
    private lazy var name: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 16)
        labelTitle.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        labelTitle.numberOfLines = 0
        labelTitle.text = "Selena Lam"
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    private lazy var comment: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font_helvetica, size: 14)
        label.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "\"What's happened to me? \" he thought. It wasn't a dream. His room…"
        self.addSubview(label)
        return label
    }()
    
    private lazy var cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .full
        cosmosView.settings.starSize = 10
        cosmosView.settings.starMargin = 8
        cosmosView.rating = 4
        cosmosView.settings.emptyImage = UIImage(named: image_detail_ic_star_empty)
        cosmosView.settings.filledImage = UIImage(named: image_detail_ic_star_full)
        self.addSubview(cosmosView)
        return cosmosView
    }()
    
    private lazy var lblRating: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 12)
        labelTitle.textColor = UIColor(red: 0.945, green: 0.792, blue: 0.137, alpha: 1)
        labelTitle.textAlignment = .left
        labelTitle.text = "4.0"
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    private lazy var lblTime: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font_helvetica, size: 10)
        label.textColor = UIColor(red: 0.608, green: 0.608, blue: 0.608, alpha: 1)
        label.text = "yesterday"
        self.addSubview(label)
        return label
    }()
    
    private lazy var viewLine: UIView = {
        let stroke = UIView()
        stroke.backgroundColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
        self.addSubview(stroke)
        return stroke
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
        
        self.imgAvatar.snp.makeConstraints {
            $0.left.top.equalTo(marginLeft)
            $0.size.equalTo(40)
        }
        
        self.name.snp.makeConstraints {
            $0.top.equalTo(self.imgAvatar.snp.top)
            $0.left.equalTo(self.imgAvatar.snp.right).offset(10)
            $0.right.equalTo(-marginLeft)
            $0.height.equalTo(22)
        }
        
        self.comment.snp.makeConstraints {
            $0.top.equalTo(self.name.snp.bottom).offset(2)
            $0.left.equalTo(self.name.snp.left)
            $0.right.equalTo(-marginLeft)
        }
        
        self.lblRating.snp.makeConstraints {
            $0.left.equalTo(self.name.snp.left)
            $0.top.equalTo(self.comment.snp.bottom).offset(12)
            $0.size.equalTo(18)
        }
        
        self.cosmosView.snp.makeConstraints {
            $0.left.equalTo(self.lblRating.snp.right).offset(5)
            $0.centerY.equalTo(self.lblRating)
            $0.height.equalTo(10)
            $0.width.equalTo(95)
        }
        
        self.lblTime.snp.makeConstraints {
            $0.left.equalTo(self.lblRating)
            $0.right.equalTo(-marginLeft)
            $0.height.equalTo(16)
            $0.bottom.equalTo(-marginLeft)
        }
        
        self.viewLine.snp.makeConstraints {
            $0.left.equalTo(self.lblRating)
            $0.right.equalTo(-marginLeft)
            $0.height.equalTo(1)
            $0.bottom.equalTo(-1)
        }
    }

}
