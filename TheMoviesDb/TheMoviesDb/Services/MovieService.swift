//
//  MovieService.swift
//  TheMoviesDb
//
//  Created by admin on 4/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: Endpoint,
                     page: Int,
                     params: [String: String]?,
                     successHandler: @escaping (_ response: MoviesResponse) -> Void,
                     errorHandler: @escaping(_ error: Error) -> Void)
    
    func fetchGenre(successHandler: @escaping (_ response: GenresResponse) -> Void,
                            errorHandler: @escaping(_ error: Error) -> Void)
    
    func fetchDetailMovie(id: Int,
                    successHandler: @escaping (_ response: Movie) -> Void,
                    errorHandler: @escaping(_ error: Error) -> Void)
    
}


public enum Endpoint: String, CaseIterable, CustomStringConvertible {
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case popular = "popular"
    case topRated = "top_rated"
    
    public var description: String {
        switch self {
        case .nowPlaying: return "Recommendations"
        case .upcoming: return "Upcoming"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        }
    }
    
    public init?(index: Int) {
        switch index {
        case 0: self = .nowPlaying
        case 1: self = .popular
        case 2: self = .upcoming
        case 3: self = .topRated
        default: return nil
        }
    }
}

public enum MovieError: Error {
    case apiError
    case invalidURL
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
