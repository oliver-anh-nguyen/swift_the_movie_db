//
//  HomeHeaderSection.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class HomeHeaderSection: UICollectionReusableView {
    
    public lazy var title: UILabel = {
        let labelTitle = UILabel()
        labelTitle.font = UIFont(name: font_helvetica_bold, size: 18)
        labelTitle.textColor = UIColor(red: 0.242, green: 0.289, blue: 0.347, alpha: 1)
        labelTitle.textAlignment = .left
        labelTitle.adjustsFontSizeToFitWidth = true
        self.addSubview(labelTitle)
        return labelTitle
    }()
    
    public lazy var btnMore: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: image_home_section_more), for: .normal)
        self.addSubview(btn)
        return btn
    }()
    
    public var moreButton: ButtonAction?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.btnMore.addTarget(self, action: #selector(clickedMore), for: .touchUpInside)
        
        self.btnMore.snp.makeConstraints {
            $0.right.equalTo(-marginLeft)
            $0.size.equalTo(22)
            $0.centerY.equalTo(self.title)
        }
        
        self.title.snp.makeConstraints {
            $0.left.equalTo(marginLeft)
            $0.right.equalTo(self.btnMore.snp.left).offset(10)
            $0.bottom.equalTo(0)
        }
    }
    
    @objc func clickedMore() {
        guard let moreButton = moreButton else{
            return
        }
        moreButton()
    }
    
}
