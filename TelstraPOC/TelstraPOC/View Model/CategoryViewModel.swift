//
//  CategoryViewModel.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class CategoryViewModel {

    static var categoryRowDataArray: [CategoryData]  = [CategoryData]()
    var screenTitle: String = ""
    var responseErrorString: String = ""
    
    func getCategoryData(completion: @escaping () -> ()) {
        NetworkManager.sharedInstance.getDataFromWebService { (responseData, error) in
            DispatchQueue.main.async {
                if responseData != nil {
                    CategoryViewModel.categoryRowDataArray = responseData?.categoryData.filter{ $0.categoryName != nil } ?? []
                    self.screenTitle = responseData?.screenTitle ?? ""
                } else {
                    self.responseErrorString = error?.localizedDescription as! String
                }
                completion()
            }
        }
    }
    
    func getResponseError() -> String {
        return self.responseErrorString
    }
    
    func getScreenTitleForTableView() -> String {
        return self.screenTitle
    }
    
    func getCountOfCategoryData() -> Int {
        return CategoryViewModel.self.categoryRowDataArray.count
    }
    
    func getCategoryDataObject(forCellNumber: Int) -> CategoryData {
        return CategoryViewModel.categoryRowDataArray[forCellNumber]
    }
}
