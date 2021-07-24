//
//  CategoryViewController.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 24/07/2021.
//

import UIKit

//MARK:- Protocol

protocol CategoryDelegate: class {
    func didSelectCategory(_ category: CategoryEntity)
}

//MARK:- Class

final class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Properties
    
    private var tableView: UITableView!
    private let viewModel: CategoryViewModel
    
    private let tableViewHeaderTitle: String = "Categories: Select one"
    
    // Use class protocol CategoryDelegate to type delegate variable
    private weak var delegate: CategoryDelegate?
    
    private init() {
        self.viewModel = CategoryViewModel()
        
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
    
    //MARK:- Functions
    
    static func goToCategory(on viewController: UIViewController, delegate: CategoryDelegate) {
        let vc = CategoryViewController()
        vc.delegate = delegate
        viewController.present(vc, animated: true, completion: nil)
    }
    
    private func setupView() {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    //MARK:- UITableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = viewModel.elementAt(indexPath)
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = category.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewHeaderTitle
    }
    
    //MARK:- UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let categorySelected = viewModel.elementAt(indexPath)
        dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectCategory(categorySelected)
        }
    }
}
