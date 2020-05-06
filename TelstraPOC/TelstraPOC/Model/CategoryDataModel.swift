//
//  CategoryDataModel.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

struct CategoryDataModel: Decodable {
    
    let screenTitle: String
    let categoryData: [CategoryData]
    
    enum CodingKeys: String, CodingKey {
        case screenTitle = "title"
        case categoryData = "rows"
    }
}

struct CategoryData: Decodable {
    
    let categoryName: String?
    let categoryDescription: String? 
    let categoryImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "title"
        case categoryDescription = "description"
        case categoryImageURL = "imageHref"
    }
}


