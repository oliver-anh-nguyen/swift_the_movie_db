//
//  DetailRecomendViewCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Nuke

class DetailRecomendViewCell: UICollectionViewCell {
    
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
    
    private lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 12)
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
            $0.left.right.equalToSuperview()
            $0.top.equalTo(marginLeft)
            $0.height.equalTo(150)
        }
        self.viewBg.viewShadow()
        
        self.imgBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.title.snp.makeConstraints {
            $0.top.equalTo(self.imgBg.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(32)
        }

    }

    func configure(viewModel: Movie) {
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
