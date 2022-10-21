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
            let alertController = AlertManager.createAlertController(
                title: title,
                message: message,
                buttonTitle: buttonTitle
            )
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
