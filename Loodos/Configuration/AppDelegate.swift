//
//  AppDelegate.swift
//  Loodos
//
//  Created by Ufuk Canlı on 21.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

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
        
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        RemoteConfigManager.configure()
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        return true
    }
}

// MARK: - Helper Methods
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

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      Messaging.messaging().apnsToken = deviceToken
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        let tokenDict = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict
        )
    }
}
