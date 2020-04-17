//
//  DetailInfoCollectionViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailHeaderSection: UICollectionReusableView {

    public lazy var imgBgTop: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "detail_bg_mockup")
        self.addSubview(img)
        return img
    }()
    
    public lazy var imgAvatar: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "detail_mockup_avatar")
        self.addSubview(img)
        return img
    }()

    public lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 24)
        labelTitle.textColor = UIColor(red: 0.243, green: 0.29, blue: 0.349, alpha: 1)
        labelTitle.textAlignment = .left
        labelTitle.text = "Justice League"
        labelTitle.adjustsFontSizeToFitWidth = true
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    public lazy var desc: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font_helvetica, size: 18)
        label.textColor = UIColor(red: 0.243, green: 0.29, blue: 0.349, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Một nhóm các siêu anh hùng được tập hợp trong các ấn phẩm khác của DC Comics, những người cùng nhau tham gia như một liên minh công lý. Những thành viên ban đầu là Aquaman…"
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        return label
    }()
    
    public lazy var btnMore: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Read more", for: .normal)
        btn.setTitleColor(UIColor(red: 0, green: 0.478, blue: 0.851, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: font_helvetica, size: 14)
        self.addSubview(btn)
        return btn
    }()
    
    public lazy var btnFavorite: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: image_detail_favorite), for: .normal)
        self.addSubview(btn)
        return btn
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let heightBg = fullWidth*220/360
        self.imgBgTop.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(heightBg)
        }
        
        self.imgAvatar.snp.makeConstraints {
            $0.left.equalTo(marginLeft)
            $0.height.equalTo(180)
            $0.width.equalTo(120)
            $0.top.equalTo(self.imgBgTop.snp.bottom).offset(-70)
        }
        
        self.title.snp.makeConstraints {
            $0.left.right.equalTo(marginLeft)
            $0.top.equalTo(self.imgAvatar.snp.bottom).offset(marginLeft)
            $0.height.equalTo(33)
        }
        
        self.desc.snp.makeConstraints {
            $0.left.right.equalTo(marginLeft)
            $0.top.equalTo(self.title.snp.bottom).offset(4)
            $0.height.equalTo(120)
        }
        
        self.btnMore.snp.makeConstraints {
            $0.right.equalTo(-marginLeft)
            $0.top.equalTo(self.desc.snp.bottom).offset(7)
            $0.height.equalTo(20)
        }
        
        self.btnFavorite.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(250)
            $0.top.equalTo(self.desc.snp.bottom).offset(56)
            $0.centerX.equalTo(self.imgBgTop)
        }
    }
}
