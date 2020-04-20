//
//  GenreViewModel.swift
//  TheMoviesDb
//
//  Created by admin on 4/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

struct GenreViewViewModel {
    
    private var genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    var title: String {
        return genre.name
    }
    
}
