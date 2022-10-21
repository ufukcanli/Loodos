//
//  AlertManager.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit.UIAlertController

enum AlertManager {
    
    static func createAlertController(
        title: String,
        message: String,
        buttonTitle: String
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Oops!",
            message: "Please check your internet connection or come back later.",
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

        return alertController
    }
}
