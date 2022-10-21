//
//  LaunchScreenViewController.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBlue
        
        configureTitleLabel()
    }
}

private extension LaunchScreenViewController {
    
    func configureTitleLabel() {
        titleLabel.text = "Loodos"
        titleLabel.textColor = .systemYellow
        titleLabel.font = .systemFont(ofSize: 35, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
