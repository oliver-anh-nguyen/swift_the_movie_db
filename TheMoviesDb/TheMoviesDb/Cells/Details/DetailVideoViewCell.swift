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
import Nuke

class DetailVideoViewCell: UICollectionViewCell {
    
    private lazy var viewBg: UIView = {
        let outerView = UIView()
        self.addSubview(outerView)
        return outerView
    }()
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "detail_mockup_video")
        img.clipsToBounds = true
        img.layer.cornerRadius = imgCornerRadius
        self.viewBg.addSubview(img)
        return img
    }()
    
    private lazy var btnPlay: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: image_detail_ic_play_white), for: .normal)
        btn.isUserInteractionEnabled = false
        self.addSubview(btn)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        self.viewBg.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.top.equalTo(marginLeft)
            $0.left.right.equalToSuperview()
        }
        self.viewBg.viewShadow()
        
        self.imgBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.btnPlay.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.imgBg)
            $0.size.equalTo(40)
        }
        
    }
    
    func configure(viewModel: MovieVideo) {
        Nuke.loadImage(
            with: viewModel.backdropURL,
            options: ImageLoadingOptions(
                transition: .fadeIn(duration: 0.33)
            ),
            into: self.imgBg
        )
    }
    
}
