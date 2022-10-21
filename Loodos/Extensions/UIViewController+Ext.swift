//
//  UIViewController+Ext.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit.UIViewController

extension UIViewController {
    
    func presentAlertOnMainThread(
        title: String,
        message: String,
        buttonTitle: String
    ) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            alertController.modalPresentationStyle = .overFullScreen
            alertController.modalTransitionStyle = .crossDissolve
            
            let okAction = UIAlertAction(
                title: buttonTitle,
                style: .default,
                handler: nil
            )
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
