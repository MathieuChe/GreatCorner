//
//  AppDelegate.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: RootNavigator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Init and setup window with navigationController
        let window = UIWindow()
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        startRootCoordinator(with: navigationController)
                
        return true
    }
    
    private func startRootCoordinator(with navigationController: UINavigationController) {
        // Start navigation with the initial view controller
        rootCoordinator = RootNavigator(navigationController: navigationController)
        rootCoordinator.startPoint()
    }

}

