//
//  ItemDetailsViewController.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 25/07/2021.
//

import UIKit

//MARK:- Class

final class ItemDetailsViewController: UIViewController {
    
    //MARK:- Properties
    
    private let itemDetailsUIModel: ItemDetailsViewUIModel
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    //MARK:- Initialization
    
    init(with model: ItemDetailsViewUIModel) {
        self.itemDetailsUIModel = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- Setup LayoutConstraint
    
    private func setupView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        let itemDetailsView = ItemDetailsView()
        itemDetailsView.setDetailsView(with: itemDetailsUIModel)
        itemDetailsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemDetailsView)
        
        let margin: CGFloat = 15.0
        
        NSLayoutConstraint.activate([
            itemDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            itemDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            itemDetailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: margin),
            itemDetailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            itemDetailsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
}
