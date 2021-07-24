//
//  ItemsListViewModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

//MARK:- Protocol

protocol DataCollectionOrTableViewModel {
    associatedtype List: Sequence
    var dataView: List { get }

    func numberOfItemsIn(_ section: Int) -> Int
    func elementAt(_ indexPath: IndexPath) -> List.Element
}

// Collection Protocol to handle index
extension DataCollectionOrTableViewModel where List: Collection {

    func numberOfItemsIn(_ section: Int) -> Int {
        return dataView.count
    }

    func elementAt(_ indexPath: IndexPath) -> List.Element {
        
        // guard case to avoid any indexPath out of range
        guard case 0...dataView.count = indexPath.row else {
            fatalError("model object cannot be found at row: \(indexPath.row)!")
        }
        let index = dataView.index(dataView.startIndex, offsetBy: indexPath.row)
        return dataView[index]
    }
}

//MARK:- Class

final class ItemsListViewModel: DataCollectionOrTableViewModel {

    //MARK:- Need to add many inputs and outputs
    let fetchItemsListService : IGetItemsListService

    // Array of items fetched from the API, dont use it to display it, use viewableList property instead
    var itemsList: [ItemViewModel] { didSet { sortViewableList() } }
    

    // MARK: Outputs

    // Array of items built from rawList property used to be display as wanted. Can be sorted. filtered, etc.
    var dataView: [ItemViewModel] { didSet { newDataAvailable?() } }

    // Closure called when new data is available and ready to be displayed
    var newDataAvailable: (() -> Void)?

    init(fetchItemsListService: IGetItemsListService) {
        self.fetchItemsListService = fetchItemsListService
        self.itemsList = []
        self.dataView = []
    }

    func fetchListItems(completion: @escaping (ErrorService?) -> Void) {
        fetchItemsListService.fetchListItems { [weak self] (result: Result<[ItemEntity], ErrorService>) in
            switch result {
            case .success(let itemsEntity):
                
                // Mapping ItemEntity with ItemViewModel
                let itemsViewModels = itemsEntity.map(ItemViewModel.init)
                self?.itemsList = itemsViewModels
                completion(nil)

            case .failure(let error):
                completion(error)
            }
        }
    }
    
    //MARK:- Sort items by date and is_urgent
    
    private func sortViewableList() {
        dataView = sortedListItems(itemsList)
    }
    
    private func sortedListItems(_ items: [ItemViewModel]) -> [ItemViewModel] {
        let sortedItemsByDate = sortedByDate(items: items)
        let sortedItemsByIsUrgent = sortedByIsUrgent(items: sortedItemsByDate)
        
        return sortedItemsByIsUrgent
    }
    
    private func sortedByDate(items: [ItemViewModel]) -> [ItemViewModel] {
        return items.sorted {
            guard let date = $0.creationDate else { return false }
            guard let nextDate = $1.creationDate else { return false }
            return date < nextDate
        }
    }
    
    func sortedByIsUrgent(items: [ItemViewModel]) -> [ItemViewModel] {
        return items.sorted {
            // Compare 1 by 1 to sort urgent item
            switch ($0.isUrgent, $1.isUrgent) {
            case (false, true): return false
            default: return true
            }
        }
    }
}
