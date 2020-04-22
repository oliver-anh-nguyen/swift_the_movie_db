//
//  MovieListViewViewModel.swift
//  TheMoviesDb
//
//  Created by admin on 4/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewViewModel {
    
    private let movieService: MovieService
    private let disposeBag = DisposeBag()
    
    init(endpoint: Endpoint, movieService: MovieService) {
        self.movieService = movieService
        self._endPoint.accept(endpoint)
        self.fetchMovies(endpoint: endpoint)
    }
    
    private let _movies = BehaviorRelay<[Movie]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    private let _page = BehaviorRelay<Int>(value: 1)
    private let _endPoint = BehaviorRelay<Endpoint>(value: .nowPlaying)
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var movies: Driver<[Movie]> {
        return _movies.asDriver()
    }
    
    var page: Driver<Int> {
        return _page.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var numberOfMovies: Int {
        return _movies.value.count
    }
    
    func viewModelForMovie(at index: Int) -> MovieViewViewModel? {
        guard index < _movies.value.count else {
            return nil
        }
        return MovieViewViewModel(movie: _movies.value[index])
    }
    
    private func fetchMovies(endpoint: Endpoint) {
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        movieService.fetchMovies(from: endpoint, page: self._page.value, params: nil, successHandler: {[weak self] (response) in
            self?._isFetching.accept(false)
            self?._movies.acceptAppending(response.results)
            
        }) { [weak self] (error) in
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
    }
    
    public func loadNextPage() {
        self._page.accept(self._page.value+1)
        self.fetchMovies(endpoint: self._endPoint.value)
    }
    
    public func refreshListMovies() {
        self._page.accept(1)
        self._movies.accept([])
        self.fetchMovies(endpoint: self._endPoint.value)
    }
    
}

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: [Element.Element]) {
        accept(value + element)
    }
}
