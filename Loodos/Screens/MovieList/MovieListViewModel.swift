//
//  MovieListViewModel.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
    func didFinishFetchingMovies()
}

final class MovieListViewModel {
    
    private(set) var movies: [MovieItem] = []
    
    weak var delegate: MovieListViewModelDelegate?
    
    var numberOfItemsInSection: Int {
        return movies.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> MovieItem {
        return movies[indexPath.item]
    }
    
    func fetchPopularMovies() {
        NetworkManager.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies.results
                self?.delegate?.didFinishFetchingMovies()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
