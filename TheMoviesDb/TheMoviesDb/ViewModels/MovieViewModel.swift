//
//  MoviesViewModel.swift
//  TheMoviesDb
//
//  Created by admin on 4/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

struct MovieViewViewModel {
    
    private var movie: Movie
    
    private static let dateFormatter: DateFormatter = {
        $0.dateStyle = .medium
        $0.timeStyle = .none
        return $0
    }(DateFormatter())
    
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var posterURL: URL {
        return movie.posterURL
    }
    
    var releaseDate: String {
        return MovieViewViewModel.dateFormatter.string(from: movie.releaseDate)
    }
    
    var rating: Double {
        return movie.voteAverage
    }
    
}
