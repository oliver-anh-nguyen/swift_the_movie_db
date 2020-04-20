//
//  HomeCategoryCollectionCell.swift
//  TheMoviesDb
//
//  Created by admin on 4/16/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class HomeCategoryCollectionCell: BaseCollectionCell {
    
    private var genreListViewViewModel: GenreListViewViewModel!
    private let disposeBag = DisposeBag()
    
    override func sizeCollection() -> CGSize {
        return size_home_category
    }
    
    override func registerCell() {
        self.collectionView.register(HomeCategoryViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.getListGenres()
    }
    
    // MARK: API
    private func getListGenres() {
        genreListViewViewModel = GenreListViewViewModel(movieService: MovieStore.shared)
        
        genreListViewViewModel.genres.drive(onNext: {[weak self] (_) in
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        genreListViewViewModel.error.drive(onNext: {(error) in
            print(error?.description ?? "")
        }).disposed(by: disposeBag)
    }
}

extension HomeCategoryCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreListViewViewModel.numberOfGenres
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCategoryViewCell.self), for: indexPath) as? HomeCategoryViewCell else {
            fatalError()
        }
        if let viewModel = genreListViewViewModel.viewModelForMovie(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        cell.imgBg.image = UIImage(named: (indexPath.row % 2 == 0) ? image_home_category_1 : image_home_category_2)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension HomeCategoryCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: marginTopCell, left: marginCell, bottom: marginCell, right: marginCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}
