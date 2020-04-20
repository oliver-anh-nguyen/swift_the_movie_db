//
//  GenreListViewViewModel.swift
//  TheMoviesDb
//
//  Created by admin on 4/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GenreListViewViewModel {
    
    private let movieService: MovieService
    private let disposeBag = DisposeBag()
    
    init(movieService: MovieService) {
        self.movieService = movieService
        self.fetchGenres()
    }
    
    private let _genres = BehaviorRelay<[Genre]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var genres: Driver<[Genre]> {
        return _genres.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var numberOfGenres: Int {
        return _genres.value.count
    }
    
    func viewModelForMovie(at index: Int) -> GenreViewViewModel? {
        guard index < _genres.value.count else {
            return nil
        }
        return GenreViewViewModel(genre: _genres.value[index])
    }
    
    private func fetchGenres() {
        self._genres.accept([])
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        movieService.fetchGenre(successHandler: {[weak self] (response) in
            self?._isFetching.accept(false)
            self?._genres.accept(response.genres)
            
        }) { [weak self] (error) in
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
    }
    
}
