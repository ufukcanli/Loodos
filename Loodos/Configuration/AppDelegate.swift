//
//  AppDelegate.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if ReachabilityManager.isConnectedToNetwork() {
            let launchScreenViewController = LaunchScreenViewController()
            presentViewController(launchScreenViewController, atLaunch: true)
        } else {
            let alertController = AlertManager.createAlertController(
                title: "Oops!",
                message: "Please check your internet connection and come back later.",
                buttonTitle: nil
            )
            presentViewController(alertController)
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
    
    func presentViewController(
        _ controller: UIViewController,
        atLaunch: Bool = false
    ) {
        guard let window = self.window else { return }
        
        let transitionVC = TransitionScreenViewController()
        setRootViewController(transitionVC)
        
        guard atLaunch else {
            window.rootViewController?.present(controller, animated: true)
            return
        }
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .flipHorizontal
        
        window.rootViewController?.present(controller, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                window.rootViewController?.dismiss(animated: true) { [self] in
                    let navigationController = UINavigationController(
                        rootViewController: MovieListViewController()
                    )
                    setRootViewController(navigationController)
                }
            }
        }
    }
}
