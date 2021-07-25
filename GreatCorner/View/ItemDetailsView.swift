//
//  ItemDetailsView.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 25/07/2021.
//

import UIKit

// MARK: -  ItemDetailsView Definition
final class ItemDetailsView: UIView {
    
    //MARK:- Properties
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setup
    
    private func setupView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK:- Setup label & image
    
    private func setLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setImageView(with url: URL?) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.downloadImageFromURL(url)
        
        imageView.isHidden = url == nil ? true : false
        
        return imageView
    }
    
    //MARK:- Setup with UI Model
    
    func setDetailsView(with model: ItemDetailsViewUIModel) {
        stackView.addArrangedSubview(setLabel(with: model.idString))
        stackView.addArrangedSubview(setLabel(with: model.titleString))
        stackView.addArrangedSubview(setLabel(with: model.descriptionString))
        stackView.addArrangedSubview(setLabel(with: model.categoryIdString))
        stackView.addArrangedSubview(setLabel(with: model.priceString))
        stackView.addArrangedSubview(setLabel(with: model.creationDateString))
        stackView.addArrangedSubview(setLabel(with: model.isUrgentString))
        stackView.addArrangedSubview(setLabel(with: model.smallImageUrlString))
        stackView.addArrangedSubview(setImageView(with: model.smallImageUrl))
        stackView.addArrangedSubview(setLabel(with: model.largeImageUrlString))
        stackView.addArrangedSubview(setImageView(with: model.largeImageUrl))
    }
}
