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
    
        view.backgroundColor = .systemGray6
        
        configureTitleLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = RemoteConfigManager.value(forKey: "LAUNCH_SCREEN_TEXT")
    }
}

private extension LaunchScreenViewController {
    
    func configureTitleLabel() {
        titleLabel.text = "N/A"
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 55, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
