//
//  ViewController.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

//MARK:- Class

class ItemsListViewController: UIViewController {

    
    //MARK:- properties
    
    private var collectionView: UICollectionView!
    
    private let numberOfItemByRow:           Int = 2
    private let cellAspectRatio:             CGFloat = 3/2
    private let minimumItemsSpacing:         CGFloat = 5.0
    private let minimumLineSpacing:          CGFloat = 30.0
    private let horizontalInset:             CGFloat = 5.0
    private let margins:                     CGFloat = 5.0

    
    //MARK:- Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    //MARK:- Setup Function

    private func setupCollectionView() {
        view.backgroundColor = .white
        navigationItem.title = "ThePlaceToBe"
        
        collectionView = setCollectionView()
    }
}

// MARK: - Collection View DataSource & Delegate

extension ItemsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    func setCollectionView() -> UICollectionView {
        let collectionViewLayout = setCollectionViewLayout(with: view.frame)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.black.cgColor
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
    

    //MARK:- CollectionView Layout
    
    func setCollectionViewLayout(with frame: CGRect) -> UICollectionViewFlowLayout {
        let itemsHorizontalInset = minimumItemsSpacing
        let collectionViewWidth = frame.width - 3 * margins
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = sizeForItem(collectionViewWidth: collectionViewWidth)
        flowLayout.minimumInteritemSpacing = minimumItemsSpacing
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: itemsHorizontalInset, bottom: 0.0, right: itemsHorizontalInset)
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
    
    func sizeForItem(collectionViewWidth: CGFloat) -> CGSize {
        let numberOfItem = CGFloat(numberOfItemByRow)
        let itemWidth = collectionViewWidth / numberOfItem - horizontalInset
        let itemHeight = itemWidth * cellAspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
    }

}

