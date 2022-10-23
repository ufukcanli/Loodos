//
//  MovieListViewModel.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
    func willUpdateViewController()
}

final class MovieListViewModel {
    
    private(set) var movies: [MovieItem] = []
    
    weak var delegate: MovieListViewModelDelegate?
    
    var title: String {
        return "Movies"
    }
    
    var emptyStateLabelIsHidden: Bool {
        return movies.count > 0 ? true : false
    }
    
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
                self?.delegate?.willUpdateViewController()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func searchMovies(with query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard !query.isEmpty else {
            movies = []
            delegate?.willUpdateViewController()
            return
        }
        NetworkManager.searchMovies(with: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies.results
                self?.delegate?.willUpdateViewController()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
