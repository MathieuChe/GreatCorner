//
//  ItemsListViewModelTests.swift
//  GreatCornerTests
//
//  Created by Mathieu Chelim on 25/07/2021.
//

import XCTest
@testable import GreatCorner

fileprivate class ItemsListBusinessService: IGetItemsListService {
    func fetchListItems(completion: @escaping (Result<[ItemEntity], ErrorService>) -> Void) {
        do {
            let items = try LoadFixtures.loadItemsListViewModel()
            completion(.success(items))
        }catch {
            completion(.failure(ErrorService.appError))
        }
    }
}

class ItemsListViewModelTests: XCTestCase {
    
    private var viewModel: ItemsListViewModel!
    
    private func loadItemsEntitiesFixture() -> [ItemEntity] {
        let fixturesData: [ItemEntity]
        do {
            fixturesData = try LoadFixtures.loadItemsListViewModel()
        } catch {
            fixturesData = []
            XCTFail("Load failed")
        }
        return fixturesData
    }
    
    override func setUpWithError() throws {
        viewModel = ItemsListViewModel(fetchItemsListService: ItemsListBusinessService())
    }
    
    override func tearDownWithError() throws {}
    
    
    func test_dataList_should_be_sorted_by_creationDate() {
        
        let sortedTitlesByCreationDate = loadItemsEntitiesFixture()
            .map(ItemViewModel.init)
            .sorted { $0.creationDate! < $1.creationDate! }
            .map(\.titleString)
        
        viewModel.fetchListItems { _ in
            XCTAssertTrue(
                self.viewModel.itemsList
                    .map(\.titleString)
                    .elementsEqual(sortedTitlesByCreationDate)
            )
        }
    }
    
    func test_dataList_should_be_sorted_by_isUrgent() {
        
        let sortedTitlesByIsUrgent = loadItemsEntitiesFixture()
            .map(ItemViewModel.init)
            .sorted {
                switch ($0.isUrgent, $1.isUrgent) {
                case (false, true): return false
                default: return true
                }
            }
            .map(\.titleString)
        
        viewModel.fetchListItems { _ in
            XCTAssertTrue(
                self.viewModel.itemsList
                    .map(\.titleString)
                    .elementsEqual(sortedTitlesByIsUrgent)
            )
        }
    }
    
}
