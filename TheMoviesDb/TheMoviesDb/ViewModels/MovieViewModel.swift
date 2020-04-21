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
        $0.dateFormat = "MMMM yyyy"
        return $0
    }(DateFormatter())
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var idMovie: Int {
        return movie.id
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
    
    var backdropURL: URL {
        return movie.backdropURL
    }
    
    var releaseDate: String {
        return MovieViewViewModel.dateFormatter.string(from: movie.releaseDate)
    }
    
    var rating: Double {
        return round(movie.voteAverage/2)
    }
    
    var movieCast: [MovieCast] {
        return movie.credits?.cast ?? []
    }
    
    var genres: [MovieGenre] {
        return movie.genres ?? []
    }
    
    var videos: [MovieVideo] {
        return movie.videos?.results ?? []
    }
    
    var recommendations: [Movie] {
        return movie.recommendations?.results ?? []
    }
}
