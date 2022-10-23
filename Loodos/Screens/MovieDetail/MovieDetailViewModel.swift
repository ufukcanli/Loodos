//
//  MovieDetailViewModel.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import Foundation

final class MovieDetailViewModel {
    
    private let movie: MovieItem!
    
    init(movie: MovieItem) {
        self.movie = movie
        debugPrint(movie)
    }
    
    var title: String {
        return "Detail"
    }
    
    var movieTitle: String {
        guard let title = movie.originalTitle else { return "N/A" }
        return title
    }
    
    var overviewText: String {
        guard let overview = movie.overview else { return "N/A" }
        return overview
    }
    
    var posterURL: URL {
        return movie.posterURL
    }
}
