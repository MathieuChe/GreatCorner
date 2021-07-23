//
//  Navigator.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

// Set RootNavigation

//MARK:- Protocol

protocol NavCoordinator {
    // Only get this variable. Impossible to set it
    var navigationController: UINavigationController { get }
    
    // Start at this ViewController
    func startPoint()
}

//MARK:- Class

final class RootNavigator: NavCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startPoint() {
        let viewController = ItemsListViewController()
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    
}
