//
//  MovieDetailViewModel.swift
//  TheMoviesDb
//
//  Created by admin on 4/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    
    private let movieService: MovieService
    private let disposeBag = DisposeBag()
    
    init(idMovie: Int, movieService: MovieService) {
        self.movieService = movieService
        self.fetchDetailMovie(idMovie: idMovie)
    }
    
    private let _movie = BehaviorRelay<Movie?>(value: nil)
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var movie: Driver<Movie?> {
        return _movie.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    func viewModel() -> MovieViewViewModel? {
        guard let movie = self._movie.value else {
            return nil
        }
        return MovieViewViewModel(movie: movie)
    }
    
    private func fetchDetailMovie(idMovie: Int) {
        self._movie.accept(nil)
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        movieService.fetchDetailMovie(id: idMovie, successHandler: {[weak self] (response) in
            self?._isFetching.accept(false)
            self?._movie.accept(response)
            
        }) { [weak self] (error) in
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
    }
    
}
