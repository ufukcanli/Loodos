//
//  MovieResponse.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import Foundation

struct MovieList: Decodable {
    let results: [MovieItem]
}

struct MovieItem: Decodable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
}
