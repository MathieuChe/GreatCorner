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
            fatalError("IndexPath's out of range at row: \(indexPath.row). Model Object can't be found!")
        }
        let index = dataView.index(dataView.startIndex, offsetBy: indexPath.row)
        return dataView[index]
    }
}

//MARK:- Class

final class ItemsListViewModel: DataCollectionOrTableViewModel, CategoryDelegate {
    
    //MARK:- Properties
    
    let fetchItemsListService : IGetItemsListService
    
    // Array of items fetched from the API, dont use it to display it, use itemsList property instead
    var itemsList: [ItemViewModel] { didSet { sortViewableList() } }
    
    // Array of items built from dataView property used to be display as wanted. Can be sorted. filtered, etc.
    var dataView: [ItemViewModel] { didSet { newDataAvailable?() } }
    
    // Closure called when new data is available and ready to be displayed
    var newDataAvailable: (() -> Void)?
    
    // Category selected by the user.
    private var categorySelected: CategoryEntity? {
        didSet {
            // Check if the category is selected, so if category is selected, it's different to nil then display remove filter
            displayRemoveFilterButton?(categorySelected != nil)
            sortViewableList()
        }
    }
    
    // Closure indicates if the remove filter button should be displayed or not.
    var displayRemoveFilterButton: ((Bool) -> Void)?
    
    init(fetchItemsListService: IGetItemsListService) {
        self.fetchItemsListService = fetchItemsListService
        self.itemsList = []
        self.dataView = []
    }
    
    //MARK:- Fetch Items function
    
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
    
    //MARK:- Sort items by date, is_urgent and filter by category
    
    private func sortViewableList() {
        dataView = sortedItemsList(itemsList, by: categorySelected)
    }
    
    private func sortedItemsList(_ items: [ItemViewModel], by category: CategoryEntity? ) -> [ItemViewModel] {
        
        let sortedItemsByDate = sortedByDate(items: items)
        
        let sortedItemsByIsUrgent = sortedByIsUrgent(items: sortedItemsByDate)
        
        // Keep sortedItems and display itemsList filtered by category
        let filteredItemsByCategory = filteredByCategory(items: sortedItemsByIsUrgent, category)
        
        return filteredItemsByCategory
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
    
    func filteredByCategory(items: [ItemViewModel],_ category: CategoryEntity?) -> [ItemViewModel] {
        guard let category = category else { return items }
        
        // Filter items array to check each item category if equal to selectedCategory
        return items.filter {$0.category == category}
    }
    
    func didSelectCategory(_ category: CategoryEntity) {
        categorySelected = category
    }
    
    func removeCategoryFilter() {
        categorySelected = nil
    }
}
