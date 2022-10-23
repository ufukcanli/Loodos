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
    private lazy var emptyStateLabel = UILabel()
    private var collectionView: UICollectionView!
    private var timer: Timer?
        
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
        configureEmptyStateLabel()
        configureNavigationBar()
        configureLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        viewModel.fetchPopularMovies()
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    
    func willUpdateViewController() {
        updateViewController()
    }
    
    func willUpdateViewController(with message: String) {
        updateViewController()
        presentAlertOnMainThread(
            title: viewModel.errorTitle,
            message: message,
            buttonTitle: viewModel.alertButtonTitle
        )
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        timer?.invalidate()
        loadingView.startAnimating()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] timer in
            self?.viewModel.searchMovies(with: searchText)
        }
    }
    
    private func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchController.searchBar.endEditing(true)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let movieItem = viewModel.cellForItemAt(indexPath: indexPath)
        let movieDetailViewModel = MovieDetailViewModel(movie: movieItem)
        let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailViewModel)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        emptyStateLabel.isHidden = viewModel.emptyStateLabelIsHidden
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
    
    func updateViewController() {
        DispatchQueue.main.async { [self] in
            loadingView.stopAnimating()
            collectionView.reloadData()
        }
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.title
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
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 200),
            loadingView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
    }
    
    func configureEmptyStateLabel() {
        emptyStateLabel.text = "🧐 What are you looking for?"
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.font = .preferredFont(forTextStyle: .body)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.addSubview(emptyStateLabel)
        
        NSLayoutConstraint.activate([
            emptyStateLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 80),
            emptyStateLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
        ])
    }
}
