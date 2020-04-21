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
import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    var heightLabelReadMore : CGFloat = 120.0
    var viewModel: MovieViewViewModel!
    
    private var movieDetailViewViewModel: MovieDetailViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: API
    private func getDetailMovie() {
        movieDetailViewViewModel = MovieDetailViewModel(idMovie: self.viewModel.idMovie
            , movieService: MovieStore.shared)
        
        movieDetailViewViewModel.movie.drive(onNext: {[weak self] (_) in
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        movieDetailViewViewModel.error.drive(onNext: {(error) in
            print(error?.description ?? "")
        }).disposed(by: disposeBag)
    }
    
    init(viewModel: MovieViewViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.getDetailMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
        self.collectionView.register(DetailSeriesCastCollectionCell.self, self.collectionView)
        self.collectionView.register(DetailVideoCollectionCell.self, self.collectionView)
        self.collectionView.register(DetailCommentCollectionCell.self, self.collectionView)
        self.collectionView.register(DetailRecomendCollectionCell.self, self.collectionView)
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == DetailSection.info {
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == DetailSection.rating {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailRatingViewCell.self), for: indexPath) as? DetailRatingViewCell else {
                fatalError()
            }
            return cell
        }
        if indexPath.section == DetailSection.series {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailSeriesCastCollectionCell.self), for: indexPath) as? DetailSeriesCastCollectionCell else {
                fatalError()
            }
            if let model = movieDetailViewViewModel.viewModel() {
                cell.arrCasts = model.movieCast
            }
            return cell
        }
        if indexPath.section == DetailSection.video {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailVideoCollectionCell.self), for: indexPath) as? DetailVideoCollectionCell else {
                fatalError()
            }
            if let model = movieDetailViewViewModel.viewModel() {
                cell.arrVideos = model.videos
            }
            return cell
        }
        if indexPath.section == DetailSection.comment {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailCommentCollectionCell.self), for: indexPath) as? DetailCommentCollectionCell else {
                fatalError()
            }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailRecomendCollectionCell.self), for: indexPath) as? DetailRecomendCollectionCell else {
            fatalError()
        }
        if let model = movieDetailViewViewModel.viewModel() {
            cell.arr = model.recommendations
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
                headerView.configure(viewModel: self.viewModel)
                if let model = movieDetailViewViewModel.viewModel() {
                    headerView.addGenre(arr: model.genres)
                }
                headerView.delegate = self
                return headerView
            }
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: DetailHeaderTitle.self), for: indexPath) as? DetailHeaderTitle else {
                    fatalError("Invalid view type")
            }
            headerView.btnMore.isHidden = true
            headerView.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
            if indexPath.section == DetailSection.rating {
                headerView.title.text = str_detail_section_rating
            }
            else if indexPath.section == DetailSection.series {
                headerView.title.text = str_detail_section_series
            }
            else if indexPath.section == DetailSection.video {
                headerView.title.text = str_detail_section_video
            }
            else if indexPath.section == DetailSection.comment {
                headerView.title.text = str_detail_section_comment
                headerView.btnMore.isHidden = false
            }
            else if indexPath.section == DetailSection.recommend {
                headerView.title.text = str_detail_section_recomend
                headerView.moreButton = {
                    print("see full recommendation list")
                }
                headerView.btnMore.isHidden = false
            }
            return headerView
            
        default:
            assert(false, "Invalid element type")
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == DetailSection.rating {
            return CGSize(width: fullWidth, height: 160)
        }
        if indexPath.section == DetailSection.series {
            return CGSize(width: fullWidth, height: 178)
        }
        if indexPath.section == DetailSection.video {
            return CGSize(width: fullWidth, height: 165)
        }
        if indexPath.section == DetailSection.comment {
            return CGSize(width: fullWidth, height: 145*3)
        }
        if indexPath.section == DetailSection.recommend {
            return CGSize(width: fullWidth, height: 250)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == DetailSection.info {
            return CGSize(width: fullWidth, height: 379 + heightLabelReadMore + 170)
        }
        return CGSize(width: fullWidth, height: 48)
        
    }
}

extension DetailViewController : DetailHeaderSectionDelegate {
    func didPressReadMore(sender: DetailHeaderSection, height: CGFloat) {
        self.heightLabelReadMore = height
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadData()
        }, completion: nil)
    }
}
