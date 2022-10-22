//
//  MovieListViewController.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private lazy var loadingView = UIActivityIndicatorView(style: .medium)
    private lazy var searchController = UISearchController()
    private var collectionView: UICollectionView!
    
    private var movies: [MovieItem] = []
    
    private let viewModel: MovieListViewModel!
    
    init(viewModel: MovieListViewModel = MovieListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureSearchController()
        configureCollectionView()
        configureNavigationBar()
        configureLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchPopularMovies()
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    
    func didFinishFetchingMovies() {
        DispatchQueue.main.async { [self] in
            loadingView.stopAnimating()
            collectionView.reloadData()
        }
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
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieItemCell.reuseIdentifier,
            for: indexPath
        ) as! MovieItemCell
        let movieItem = viewModel.cellForItemAt(indexPath: indexPath)
        cell.populateCell(with: MovieItemViewModel(movie: movieItem))
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
    
    func configureLoadingView() {
        collectionView.addSubview(loadingView)
        
        loadingView.startAnimating()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 150),
            loadingView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
        ])
    }
}
