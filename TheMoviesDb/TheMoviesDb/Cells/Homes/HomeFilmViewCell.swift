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
import Nuke

class HomeFilmViewCell: UICollectionViewCell {
    
    public var detailButton: ButtonAction?
    
    private lazy var viewBg: UIView = {
        let outerView = UIView()
        self.addSubview(outerView)
        return outerView
    }()
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = imgCornerRadius
        self.viewBg.addSubview(img)
        return img
    }()
    
    private lazy var btnDetail: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: image_home_detail_more), for: .normal)
        self.addSubview(btn)
        return btn
    }()
    
    private lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 15)
        labelTitle.textColor = UIColor(red: 0.243, green: 0.29, blue: 0.349, alpha: 1)
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        self.addSubview(labelTitle)
        return labelTitle
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
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(210)
        }
        self.viewBg.viewShadow()
        
        self.imgBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.btnDetail.snp.makeConstraints {
            $0.right.equalTo(0)
            $0.top.equalTo(self.imgBg.snp.bottom).offset(10)
            $0.height.equalTo(18)
            $0.width.equalTo(4.5)
        }
        
        self.title.snp.makeConstraints {
            $0.top.equalTo(self.imgBg.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.left.equalTo(10)
            $0.right.equalTo(self.btnDetail.snp.left).offset(-5)
        }
        
        self.btnDetail.addTarget(self, action: #selector(clickedDetail), for: .touchUpInside)
    }
    
    @objc func clickedDetail() {
        guard let detailButton = detailButton else{
            return
        }
        detailButton()
    }
    
    func configure(viewModel: MovieViewViewModel) {
        self.title.text = viewModel.title
        Nuke.loadImage(
            with: viewModel.posterURL,
            options: ImageLoadingOptions(
                transition: .fadeIn(duration: 0.33)
            ),
            into: self.imgBg
        )
    }
    
}
