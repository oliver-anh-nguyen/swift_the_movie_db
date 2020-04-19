//
//  MovieListViewViewModel.swift
//  TheMoviesDb
//
//  Created by admin on 4/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class MovieListViewViewModel {

    private let movieService: MovieService
    private var movies = [Movie]()
    private var error = ""
    private var isFetching = false
    
    init(enpoint: Endpoint, movieService: MovieService) {
        self.movieService = movieService
    }
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    func viewModelForMovie(at index: Int) -> MovieViewViewModel? {
        guard index < movies.count else {
            return nil
        }
        return MovieViewViewModel(movie: movies[index])
    }
    
    private func fetchMovies(endpoint: Endpoint) {
        self.movies.removeAll()
        self.isFetching = true
        self.movieService.fetchMovies(from: endpoint, params: nil, successHandler: {[weak self] (response) in
            self?.isFetching = false
            self?.movies = response.results
            
        }) { [weak self] (error) in
            self?.isFetching = false
            self?.error = error.localizedDescription
        }
    }
    
}
