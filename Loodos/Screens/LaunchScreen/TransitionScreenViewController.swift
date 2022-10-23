//
//  TransitionScreenViewController.swift
//  Loodos
//
//  Created by Ufuk Canlı on 23.10.2022.
//

import UIKit

final class TransitionScreenViewController: UIViewController {
    
    private lazy var loadingView = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        configureLoadingView()
    }
}

private extension TransitionScreenViewController {
    
    func configureLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.startAnimating()
        
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
