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
        let categorylbl = UILabel()
        categorylbl.font = UIFont.boldSystemFont(ofSize: 20)
        categorylbl.textAlignment = .left
        return categorylbl
    }()
    
    private let categoryDescriptionLabel: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.font = UIFont.systemFont(ofSize: 16)
        descriptionLbl.textAlignment = .left
        descriptionLbl.numberOfLines = 0
        descriptionLbl.sizeToFit()
        return descriptionLbl
    }()
    private lazy var categoryImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
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
}
