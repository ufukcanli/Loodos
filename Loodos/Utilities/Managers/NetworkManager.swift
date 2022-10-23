//
//  NetworkManager.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import Foundation

enum NetworkError: String, Error {
    case unableToComplete = "Unable complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}

enum NetworkManager {
    static let BASE_URL = "https://api.themoviedb.org"
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    
    case trendingMovies
    case upcomingMovies
    case popularMovies
    case topRatedMovies
//    case movieDetail(Int)
    case searchMovies(String)

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
//        case .movieDetail(let id):
//            return "\(NetworkManager.BASE_URL)/3/movie/\(id)?api_key=\(NetworkManager.API_KEY)"
        case .searchMovies(let query):
            return "\(NetworkManager.BASE_URL)/3/search/movie?api_key=\(NetworkManager.API_KEY)&query=\(query)"
        }
    }
    
    var url: URL { URL(string: endpoint)! }
}

extension NetworkManager {
    
    static func getTrendingMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.trendingMovies.url, completion: completion)
    }
    
    static func getUpcomingMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.upcomingMovies.url, completion: completion)
    }
    
    static func getPopularMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.popularMovies.url, completion: completion)
    }
    
    static func getTopRatedMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.topRatedMovies.url, completion: completion)
    }
    
    static func searchMovies(with query: String, completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.searchMovies(query).url, completion: completion)
    }
}

private extension NetworkManager {
    
    static func taskForGetRequest<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
