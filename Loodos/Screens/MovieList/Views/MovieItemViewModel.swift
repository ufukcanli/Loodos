//
//  MovieItemViewModel.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import Foundation

final class MovieItemViewModel {
    
    private let movie: MovieItem!
    
    init(movie: MovieItem) {
        self.movie = movie
    }
    
    var movieTitle: String {
        guard let title = movie.originalTitle else { return "N/A" }
        return title
    }
    
    var posterURL: URL {
        return movie.posterURL
    }
}
