//
//  MovieListViewController.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private lazy var searchController = UISearchController()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureSearchController()
        configureCollectionView()
        configureNavigationBar()
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {}
}

extension MovieListViewController: UICollectionViewDelegate {}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 15
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieItemCell.reuseIdentifier,
            for: indexPath
        ) as! MovieItemCell
        return cell
    }
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
        title = "Movies"
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIManager.createThreeColumnFlowLayout(in: view)
        )
        collectionView.register(
            MovieItemCell.self,
            forCellWithReuseIdentifier: MovieItemCell.reuseIdentifier
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
}
