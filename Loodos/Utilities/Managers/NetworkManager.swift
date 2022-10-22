//
//  NetworkManager.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import Foundation

enum NetworkManager {
    static let BASE_URL = "https://api.themoviedb.org"
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    
    case trendingMovies
    case upcomingMovies
    case popularMovies
    case topRatedMovies

    var endpoint: String {
        switch self {
        case .trendingMovies:
            return "\(NetworkManager.BASE_URL)/3/trending/movie/day?api_key=\(NetworkManager.API_KEY)"
        case .upcomingMovies:
            return "\(NetworkManager.BASE_URL)/3/movie/upcoming?api_key=\(NetworkManager.API_KEY)"
        case .popularMovies:
            return "\(NetworkManager.BASE_URL)/3/movie/popular?api_key=\(NetworkManager.API_KEY)"
        case .topRatedMovies:
            return "\(NetworkManager.BASE_URL)/3/movie/top_rated?api_key=\(NetworkManager.API_KEY)"
        }
    }
    
    var url: URL { URL(string: endpoint)! }
}

extension NetworkManager {
    
    static func getTrendingMovies(completion: @escaping (Result<MovieList, Error>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.trendingMovies.url, completion: completion)
    }
    
    static func getUpcomingMovies(completion: @escaping (Result<MovieList, Error>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.upcomingMovies.url, completion: completion)
    }
    
    static func getPopularMovies(completion: @escaping (Result<MovieList, Error>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.popularMovies.url, completion: completion)
    }
    
    static func getTopRatedMovies(completion: @escaping (Result<MovieList, Error>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.topRatedMovies.url, completion: completion)
    }
}

private extension NetworkManager {
    
    static func taskForGetRequest<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { return}
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return}
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
