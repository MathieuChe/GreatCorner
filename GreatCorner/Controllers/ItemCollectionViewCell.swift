//
//  ItemCollectionViewCell.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Properties
    
    static let identifier: String = "ItemCustomCell"
        
    private var topContainerView: UIView = {
        let topContainerView = UIView()
        topContainerView.backgroundColor = .clear
        return topContainerView
    }()
        
    private var bottomContainerView: UIView = {
        let bottomContainerView = UIView()
        bottomContainerView.backgroundColor = .clear
        return bottomContainerView
    }()
    
    private var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.italicSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var isUrgentPictureImageView: UIImageView = {
        let isUrgent = UIImageView()
        return isUrgent
    }()
    
    // A task, like downloading a specific resource, performed in a URL session.
    private var imageTask: URLSessionTask?
    
    //MARK:- Init Custom Cell
        
    // Initialize the new object immediately after memory for it has been allocated.
    init() {
        super.init(frame: .zero)
        setupCustomView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // To prepare any clean up necessary to the view before reusing
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
        isUrgentPictureImageView.image = nil
        imageTask?.cancel()
    }
    
    //MARK:- Functions

    // Setup all views
    private func setupCustomView() {
        setupContentView()
        setupTopContainer()
        setupBottomContainer()
    }
    
    private func setupContentView() {
        setupCornerRadius()
    }
        
    // MARK: Setup Top Container

    private func setupTopContainer() {
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topContainerView)
        NSLayoutConstraint.activate(
            [
                topContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                topContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                topContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                topContainerView.heightAnchor.constraint(equalToConstant: (3/4 * contentView.frame.height))
            ]
        )
        setupImageView()
        setupIsUrgentPictureImageView()
    }
        
    private func setupImageView() {
        
        pictureImageView = UIImageView(frame: topContainerView.frame)
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.setupCornerRadius()
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.addSubview(pictureImageView)
        NSLayoutConstraint.activate(
            [
                pictureImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
                pictureImageView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
                pictureImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
                pictureImageView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor)
            ]
        )
    }
    
    private func setupIsUrgentPictureImageView() {
        isUrgentPictureImageView.contentMode = .scaleAspectFill
        isUrgentPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.addSubview(isUrgentPictureImageView)
        NSLayoutConstraint.activate(
            [
                isUrgentPictureImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
                isUrgentPictureImageView.topAnchor.constraint(equalToSystemSpacingBelow: topContainerView.topAnchor, multiplier: 1),
                isUrgentPictureImageView.heightAnchor.constraint(equalTo: isUrgentPictureImageView.widthAnchor, multiplier: 0.4),
                isUrgentPictureImageView.widthAnchor.constraint(equalToConstant: 80)
            ]
        )
    }
    
    // MARK: Setup Bottom Container
    
    private func setupBottomContainer() {
        bottomContainerView = UIView()
        bottomContainerView.backgroundColor = .clear
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomContainerView)
        NSLayoutConstraint.activate(
            [
                bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
                bottomContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                bottomContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
        
        setupBottomElements()
    }
    
    private func setupBottomElements() {
        let bottomStackView: UIStackView = UIStackView()
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillProportionally
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.addSubview(bottomStackView)
        NSLayoutConstraint.activate(
            [
                bottomStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
                bottomStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
                bottomStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
                bottomStackView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor)
            ]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(titleLabel)
        
        let secondLineStackView: UIStackView = UIStackView()
        secondLineStackView.axis = .horizontal
        secondLineStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(secondLineStackView)
        
        secondLineStackView.addArrangedSubview(priceLabel)
        
        let thirdLineStackView = UIStackView()
        thirdLineStackView.axis = .horizontal
        thirdLineStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(thirdLineStackView)
        thirdLineStackView.addArrangedSubview(categoryLabel)
        
    }
    
    //MARK:- Config Cell
        
    func configure(with model: ItemCellUIModel) {
        configTitleLabel(with: model.title)
        configPriceLabel(with: model.price)
        configCategoryLabel(with: model.categoryDescription ?? "")
        configIsUrgentPicture(with: model.isUrgentPictureImageName)
        configImageView(with: model.imageUrl, or: model.defaultPictureImageName)
    }
    
    func configTitleLabel(with title: String) {
        titleLabel.text = title
    }
    
    func configPriceLabel(with price: Double) {
        priceLabel.text = "\(price)0 €"
    }
    
    func configCategoryLabel(with category: String) {
        categoryLabel.text = category
    }
    
    func configIsUrgentPicture(with isUrgentImageName: String?) {
        if let imageName = isUrgentImageName {
            isUrgentPictureImageView.image = UIImage(named: imageName)
        }
    }
    
    func configImageView(with url: URL?, or emptyImageName: String) {
        let placeholderImage = UIImage(named: emptyImageName)
        imageTask = pictureImageView.downloadImageFromURL(url, with: placeholderImage)
    }
}
