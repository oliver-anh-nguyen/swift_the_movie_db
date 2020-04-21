//
//  DetailSeriesCastViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class DetailSeriesCastViewCell: UICollectionViewCell {
    
    private lazy var viewBg: UIView = {
        let outerView = UIView()
        self.addSubview(outerView)
        return outerView
    }()
    
    private lazy var imgBg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: image_detail_avatar)
        img.clipsToBounds = true
        img.layer.cornerRadius = imgCornerRadius
        self.viewBg.addSubview(img)
        return img
    }()
    
    private lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 12)
        labelTitle.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        labelTitle.textAlignment = .justified
        labelTitle.numberOfLines = 1
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    private lazy var desc: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: font_helvetica, size: 12)
        label.textColor = UIColor(red: 0.608, green: 0.608, blue: 0.608, alpha: 1)
        label.textAlignment = .justified
        label.numberOfLines = 1
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
        
        self.viewBg.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(70)
            $0.height.equalTo(102)
            $0.top.equalTo(15)
        }
        self.viewBg.viewShadow()
        
        self.imgBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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
    
    func configure(viewModel: MovieCast) {
        if viewModel.profilePath != nil {
            Nuke.loadImage(
                with: viewModel.profileURL,
                options: ImageLoadingOptions(
                    transition: .fadeIn(duration: 0.33)
                ),
                into: self.imgBg
            )
        }
        self.title.text = viewModel.name
        self.desc.text = viewModel.character
    }
    
}
