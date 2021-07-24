//
//  RootNavigator.swift
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
    
    // MARK: Controller in charge of Navigation
    let navigationController: UINavigationController
    
    // MARK: Dependency property to inject
    private let httpService: HTTPService
    private let httpConfiguration: HTTPConfiguration
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.httpConfiguration = HTTPConfiguration()
        self.httpService = HTTPService()
    }
    
    func startPoint() {
        let dataAccess = HTTPListItemsDataAccessor(httpService: httpService, httpConfiguration: httpConfiguration)
        let fetchItemsListService = ItemsListService(dataAccessor: dataAccess)
        let viewModel = ItemsListViewModel(fetchItemsListService: fetchItemsListService)
        let viewController = ItemsListViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    
}
