//
//  UIManager.swift
//  Loodos
//
//  Created by Ufuk Canlı on 22.10.2022.
//

import UIKit

enum UIManager {
    
    static let placeholderImage = UIImage(named: "placeholder")!.withRenderingMode(.alwaysOriginal)
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 20
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
        flowLayout.itemSize = CGSize(
            width: itemWidth,
            height: itemWidth + 50
        )
        
        return flowLayout
    }
}
