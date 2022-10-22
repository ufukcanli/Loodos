//
//  MovieListViewController.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private lazy var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Movies"
        
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {}
}

private extension MovieListViewController {
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
