//
//  MovieItemCell.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import UIKit.UICollectionViewCell

final class MovieItemCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MovieItemCell.self)
    
    private lazy var titleLabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .systemRed
        
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell(with movie: MovieItem) {
        titleLabel.text = movie.originalTitle
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
}
