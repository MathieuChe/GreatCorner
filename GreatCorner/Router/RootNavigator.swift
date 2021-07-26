//
//  RootNavigator.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

//MARK:- Protocol

protocol NavCoordinator {
    
    // Only get this variable. Don't need to set it
    var navigationController: UINavigationController { get }
    
    // Start at this ViewController
    func startPoint()
}

//MARK:- Class

final class RootNavigator: NavCoordinator, ItemDelegate {
    
    // MARK: Controller in charge of Navigation
    
    let navigationController: UINavigationController
    
    // MARK: Dependency property to inject
    
    private let httpService: HTTPService
    private let httpConfiguration: HTTPConfiguration
    
    //MARK:- navigation Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.httpConfiguration = HTTPConfiguration()
        self.httpService = HTTPService()
    }
    
    //MARK:- Setup startPoint navigationController
    
    func startPoint() {
        // Get all items configured while the viewController is displayed
        let dataAccess = HTTPListItemsData(httpService: httpService, httpConfiguration: httpConfiguration)
        let fetchItemsListService = ItemsListService(dataAccessor: dataAccess)
        let viewModel = ItemsListViewModel(fetchItemsListService: fetchItemsListService)
        let viewController = ItemsListViewController(viewModel: viewModel, routingDelegate: self)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    //MARK:- Setup navigation to itemDetailsViewController
    
    // Set the rootNavigation to push itemDetailsViewController if item is selected
    func didSelectItem(itemViewModel: ItemViewModel) {
        let itemDetailsViewController = ItemDetailsViewController(with: itemViewModel)
        navigationController.pushViewController(itemDetailsViewController, animated: true)
    }
    
    
}
