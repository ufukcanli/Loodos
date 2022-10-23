//
//  MovieDetailViewController.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var overviewLabel = UILabel()
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private var padding: CGFloat = 16
    
    private let viewModel: MovieDetailViewModel!
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureContentView()
        configureViewController()
        configureImageView()
        configureTitleLabel()
        configureOverviewLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViewController()
    }
}

private extension MovieDetailViewController {
    
    func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 50)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    func configureContentView() {
        contentView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.addSubview(contentView)
    }
    
    func updateViewController() {
        titleLabel.text = viewModel.movieTitle
        overviewLabel.text = viewModel.overviewText
        imageView.kf.setImage(with: viewModel.posterURL)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        title = viewModel.title
    }
    
    func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 550)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = viewModel.movieTitle
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding)
        ])
    }
    
    func configureOverviewLabel() {
        overviewLabel.textColor = .label
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .preferredFont(forTextStyle: .body)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding)
        ])
    }
}
