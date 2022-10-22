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
    
    private var padding: CGFloat = 32
    
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

        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        configureImageView()
        configureTitleLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViewController()
    }
}

private extension MovieDetailViewController {
    
    func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGreen
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 550)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Moview name"
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding)
        ])
    }
    
    func updateViewController() {
        titleLabel.text = viewModel.movieTitle
        imageView.kf.setImage(with: viewModel.posterURL)
    }
}
