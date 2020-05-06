//
//  CategoryCell.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UITableViewCell {
    
    private let categoryNameLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 20)
        categoryLabel.textColor = UIColor.init(named: "TextLabelColorTheme")
        categoryLabel.textAlignment = .left
        return categoryLabel
    }()
    
    private let categoryDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.init(named: "TextLabelColorTheme")
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        return descriptionLabel
    }()
    private lazy var categoryImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(categoryImageView)
        categoryImageView.anchorView(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, enableInsets: false)
        categoryImageView.anchorSize(width: CGFloat(Constant.imageViewWidth), height: CGFloat(Constant.imageViewHeight))
        
        addSubview(categoryNameLabel)
        categoryNameLabel.anchorView(top: topAnchor, left: categoryImageView.rightAnchor, bottom: nil, right: rightAnchor, enableInsets: false)
        
        addSubview(categoryDescriptionLabel)
        categoryDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(Constant.descriptionLabelHeight)).isActive = true
        categoryDescriptionLabel.anchorView(top: categoryNameLabel.bottomAnchor, left: categoryImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, enableInsets: false)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Other methods
    
    /// Used this method to set data on respective table view cell
    func setCategoryData() {
        let categoryData = CategoryViewModel().getCategoryDataObject(forCellNumber: self.tag) as CategoryData
        categoryNameLabel.text = categoryData.categoryName
        categoryDescriptionLabel.text = categoryData.categoryDescription
        
        guard let imageURL = categoryData.categoryImageURL else {
            categoryImageView.image = UIImage.init(named: "NoImage")
            return
        }
        categoryImageView.loadImageFromURL(imageURL, placeHolder: UIImage.init(named: "NoImage"))
    }
}
