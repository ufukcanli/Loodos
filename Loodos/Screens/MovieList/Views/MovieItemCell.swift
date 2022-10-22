//
//  MovieItemCell.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import UIKit
import Kingfisher

final class MovieItemCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MovieItemCell.self)
    
    private lazy var titleLabel = UILabel()
    private lazy var imageView = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .systemRed
        
        configureImageView()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell(with movie: MovieItem?) {
        if let movie = movie {
            titleLabel.text = movie.originalTitle
            imageView.kf.setImage(with: movie.posterURL)
        }
    }
}

private extension MovieItemCell {
    
    func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureImageView() {
        imageView.backgroundColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
}
