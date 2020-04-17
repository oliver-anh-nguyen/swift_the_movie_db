//
//  DetailViewController.swift
//  TheMoviesDb
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    private lazy var btnBack: UIButton = {
        let btn = UIButton(type:.custom)
        btn.setImage(UIImage(named: image_detail_back), for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()
    
    private func setupLayout() {
        self.view.backgroundColor = .gray
        self.navigationController?.navigationBar.isHidden = true
        
        self.createCollectionView()
        self.setAutoLayout()
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.collectionView.bounces = false
        self.collectionView.alwaysBounceVertical = false
        self.collectionView.register(DetailRatingViewCell.self, self.collectionView)
        self.collectionView.registerHeader(DetailHeaderSection.self, self.collectionView)
        self.collectionView.registerHeader(DetailHeaderTitle.self, self.collectionView)
    }
    
    private func setAutoLayout() {
        self.btnBack.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.left.equalTo(16)
            $0.top.equalTo(37 + heightStatusBar())
        }
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension DetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == DetailSection.info {
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailRatingViewCell.self), for: indexPath) as? DetailRatingViewCell else {
            fatalError()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == DetailSection.info {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: DetailHeaderSection.self), for: indexPath) as? DetailHeaderSection else {
                        fatalError("Invalid view type")
                }
                headerView.backgroundColor = .white
                return headerView
            }
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: DetailHeaderTitle.self), for: indexPath) as? DetailHeaderTitle else {
                    fatalError("Invalid view type")
            }
            headerView.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
            if indexPath.section == DetailSection.rating {
                headerView.title.text = str_detail_section_rating
            }
            return headerView
            
        default:
            assert(false, "Invalid element type")
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: fullWidth, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == DetailSection.info {
            return CGSize(width: fullWidth, height: 379 + 120 + 170)
        }
        return CGSize(width: fullWidth, height: 48)
        
    }
}
