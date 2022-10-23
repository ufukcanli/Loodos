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
    
    private lazy var imageView = UIImageView()
    
    private var viewModel: MovieItemViewModel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell(with viewModel: MovieItemViewModel) {
        self.viewModel = viewModel
        imageView.kf.setImage(
            with: viewModel.posterURL,
            placeholder: UIImage(named: "placeholder")!
        )
    }
}

private extension MovieItemCell {
    
    func configureCell() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func configureImageView() {
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}
