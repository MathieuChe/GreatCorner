//
//  ItemsListViewController.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

//MARK:- Protocol Delegate

// To bind action to model
protocol ItemDelegate: class { func didSelectItem(itemViewModel: ItemViewModel)}

//MARK:- Class

final class ItemsListViewController: UIViewController {
    
    
    //MARK:- properties
    
    private var collectionView: UICollectionView!
    
    private let numberOfItemByRow:           Int = 2
    private let cellAspectRatio:             CGFloat = 3/2
    private let minimumItemsSpacing:         CGFloat = 5.0
    private let minimumLineSpacing:          CGFloat = 30.0
    private let horizontalInset:             CGFloat = 5.0
    private let margins:                     CGFloat = 5.0
    
    private let viewModel: ItemsListViewModel
    
    private var removeFilterButton: UIButton = {
        let removeFilterButton = UIButton(type: .custom)
        removeFilterButton.setTitle("Remove filter", for: .normal)
        removeFilterButton.setTitleColor(.white, for: .normal)
        removeFilterButton.isHidden = true
        removeFilterButton.setupCornerRadius()
        removeFilterButton.backgroundColor = .orange
        return removeFilterButton
    }()
    
    // Use class protocol ItemDelegate to type delegate variable
    public weak var delegate: ItemDelegate?
    
    //MARK:- Initialization
    
    init(viewModel: ItemsListViewModel, routingDelegate: ItemDelegate) {
        self.viewModel = viewModel
        self.delegate = routingDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        linkCollectionViewToViewModel()
        configureCollectionView()
    }
    
    //MARK:- Setup Function
    
    private func setupCollectionView() {
        view.backgroundColor = .white
        navigationItem.title = "GreatCorner"
        
        collectionView = setCollectionView()
        setupFilterNavigationBarItem()
        setupRemoveFilterButton()
    }
    
    private func setupFilterNavigationBarItem() {
        let categoryFilter = UIBarButtonItem(title: "Categories >", style: .plain, target: self, action: #selector(filterButtonPressed))
        categoryFilter.tintColor = .orange
        navigationItem.rightBarButtonItem = categoryFilter
    }
    
    private func setupRemoveFilterButton() {
        removeFilterButton.addTarget(self, action: #selector(removeFilterButtonPressed), for: .touchUpInside)
        removeFilterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(removeFilterButton)
        
        NSLayoutConstraint.activate([
            removeFilterButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            removeFilterButton.topAnchor.constraint(equalTo: collectionView.topAnchor),
            removeFilterButton.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.3)
        ])
    }
    
    // MARK: Button actions
    
    @objc
    private func filterButtonPressed() {
        CategoryViewController.goToCategory(on: self, delegate: viewModel)
    }
    
    @objc
    private func removeFilterButtonPressed() {
        viewModel.removeCategoryFilter()
    }
}

//MARK:- Extension

extension ItemsListViewController {
    
    func linkCollectionViewToViewModel() {
        viewModel.newDataAvailable = { [weak self] in
            self?.reloadCollectionViewData()
        }
        viewModel.displayRemoveFilterButton = { [weak self] shouldDisplayButton in
            
            // Update isHidden Bool depend on displayRemoveFilterButton function
            self?.removeFilterButton.isHidden = !shouldDisplayButton
        }
    }
    
    func configureCollectionView() {
        viewModel.fetchListItems { [weak self] error in
            if let error: ErrorService = error {
                ErrorPresenter.showError(message: error.localizedDescription, on: self, dismissAction: nil)
            }
        }
    }
    
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
        }
    }
}

// MARK: - Collection View DataSource & Delegate

extension ItemsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ItemCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCollectionViewCell.identifier,
            for: indexPath
        ) as? ItemCollectionViewCell else {
            fatalError("Error cell dequeue")
        }
        let model: ItemViewModel = viewModel.elementAt(indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func setCollectionView() -> UICollectionView {
        let collectionViewLayout: UICollectionViewFlowLayout = setCollectionViewLayout(with: view.frame)
        let collectionView: UICollectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margins),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: ItemCollectionViewCell.identifier
        )
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModelSelected = viewModel.elementAt(indexPath)
        delegate?.didSelectItem(itemViewModel: viewModelSelected)
    }
    
    //MARK:- CollectionView Layout
    
    func setCollectionViewLayout(with frame: CGRect) -> UICollectionViewFlowLayout {
        let collectionViewWidth: CGFloat = frame.width - 3 * margins
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = sizeForItem(collectionViewWidth: collectionViewWidth)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = minimumItemsSpacing
        flowLayout.minimumLineSpacing = minimumLineSpacing
        
        return flowLayout
    }
    
    func sizeForItem(collectionViewWidth: CGFloat) -> CGSize {
        let numberOfItem: CGFloat = CGFloat(numberOfItemByRow)
        let itemWidth: CGFloat = collectionViewWidth / numberOfItem - horizontalInset
        let itemHeight: CGFloat = itemWidth * cellAspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
