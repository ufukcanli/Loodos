//
//  AppDelegate.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if ReachabilityManager.isConnectedToNetwork() {
            let launchScreenViewController = LaunchScreenViewController()
            setRootViewController(launchScreenViewController)
        } else {
            let alertController = AlertManager.createAlertController(
                title: "Oops!",
                message: "Please check your internet connection or come back later.",
                buttonTitle: "OK"
            )
            presentAlertController(alertController)
        }
        
        return true
    }
}

private extension AppDelegate {
    
    func setRootViewController(_ viewController: UIViewController) {
        guard let window = self.window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func presentAlertController(_ controller: UIAlertController) {
        guard let window = self.window else { return }
        
        let rootViewController = UIViewController()
        rootViewController.view.backgroundColor = .systemBackground
        setRootViewController(rootViewController)
        
        window.rootViewController?.present(controller, animated: true)
    }
}
