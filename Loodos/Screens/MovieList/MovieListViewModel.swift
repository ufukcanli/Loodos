//
//  MovieListViewModel.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import FirebaseAnalytics

protocol MovieListViewModelDelegate: AnyObject {
    func willUpdateViewController()
    func willUpdateViewController(with message: String)
}

final class MovieListViewModel {
    
    private(set) var movies: [MovieItem] = []
    
    weak var delegate: MovieListViewModelDelegate?
    
    var title: String {
        return "Movies"
    }
    
    var errorTitle: String {
        return "Something went wrong!"
    }
    
    var alertButtonTitle: String {
        return "OK"
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
    
    func didSelectItemAt(indexPath: IndexPath) {
        let movieItem = movies[indexPath.item]
        FirebaseAnalytics.Analytics.logEvent(
            "DETAIL_SCREEN_VIEWED",
            parameters: [
                AnalyticsParameterScreenName: "MOVIE_DETAIL_SCREEN",
                "MOVIE_NAME": movieItem.originalTitle!
            ]
        )
    }
    
    func fetchPopularMovies() {
        NetworkManager.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies.results
                self?.delegate?.willUpdateViewController()
            case .failure(let error):
                self?.delegate?.willUpdateViewController(with: error.rawValue)
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
                self?.delegate?.willUpdateViewController(with: error.rawValue)
            }
        }
    }
}
