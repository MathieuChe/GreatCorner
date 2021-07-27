//
//  RootNavigatorTests.swift
//  GreatCornerTests
//
//  Created by Mathieu Chelim on 26/07/2021.
//

import XCTest
@testable import GreatCorner

class RootNavigatorTests: XCTestCase {
    
    private var rootNavigator: RootNavigator!

    override func setUpWithError() throws {
        rootNavigator = RootNavigator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_startPoint_should_set_first_viewController() {
        rootNavigator.start()
        
        XCTAssertTrue(rootNavigator.navigationController.viewControllers.first! is ItemsListViewController)
    }

}
