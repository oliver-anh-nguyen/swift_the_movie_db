//
//  DetailVideoViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailVideoViewCell: UICollectionViewCell {
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "detail_mockup_video")
        self.addSubview(img)
        return img
    }()
    
    private lazy var btnPlay: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: image_detail_ic_play), for: .normal)
        self.addSubview(btn)
        return btn
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
            $0.height.equalTo(120)
            $0.top.equalTo(marginLeft)
            $0.left.right.equalToSuperview()
        }
        
        self.btnPlay.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        self.imgBg.normalShadow()
    }
    
}
