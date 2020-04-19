//
//  HomeUpcomingCollectionCell.swift
//  TheMoviesDb
//
//  Created by Anh Nguyen on 4/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class HomeUpcomingCollectionCell: BaseCollectionCell {
    
    private var movieListViewViewModel: MovieListViewViewModel!
    private let disposeBag = DisposeBag()
    
    override func sizeCollection() -> CGSize {
        return size_home_other
    }
    
    override func registerCell() {
        self.collectionView.register(HomeFilmViewCell.self, self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.getListMovies()
    }
    
    // MARK: API
    private func getListMovies() {
        movieListViewViewModel = MovieListViewViewModel(endpoint: .upcoming
            , movieService: MovieStore.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[weak self] (_) in
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        movieListViewViewModel.error.drive(onNext: {(error) in
            print(error?.description ?? "")
        }).disposed(by: disposeBag)
    }
    
}

extension HomeUpcomingCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListViewViewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeFilmViewCell.self), for: indexPath) as? HomeFilmViewCell else {
            fatalError()
        }
        if let viewModel = movieListViewViewModel.viewModelForMovie(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        cell.detailButton = {
            print(indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


extension HomeUpcomingCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: marginTopCell, left: marginCell, bottom: marginCell, right: marginCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingCell
    }
    
}
