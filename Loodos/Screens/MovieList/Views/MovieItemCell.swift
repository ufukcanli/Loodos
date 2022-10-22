//
//  MovieItemCell.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import UIKit.UICollectionViewCell

final class MovieItemCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MovieItemCell.self)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
