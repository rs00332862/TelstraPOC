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
    
    /// To initiate webservice call to network manager
    /// Used this method to get latest data from web service
    ///
    /// - Returns: calls completion block to calling function, which ensure method call in executed and finished
    func getCategoryData(completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.sharedInstance.getDataFromWebService { responseData in
            DispatchQueue.main.async {
                switch(responseData) {
                case .success(let responseData):
                    CategoryViewModel.categoryRowDataArray = responseData.categoryData.filter{ $0.categoryName != nil }
                    self.screenTitle = responseData.screenTitle
                    completion(.success(true))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// To return screen title to be displayed on table view controller
    /// Used this method if user want to get title string received from webservice
    ///
    /// - Returns: title to be displayed on table view controller.
    func getScreenTitleForTableView() -> String {
        return self.screenTitle
    }
    
    /// To return categoryData Object count for table view data source method
    /// Used this method if user want to know the count of data object received from service
    ///
    /// - Returns: CategoryData Model object count
    func getCountOfCategoryData() -> Int {
        return CategoryViewModel.self.categoryRowDataArray.count
    }
    
    /// To return categoryData Object for provided cell number
    ///
    /// - Parameter forCellNumber: index number of cell so data can be return for approriate cell
    /// - Returns: CategoryData Model  Object contains title, description and imageURL data
    func getCategoryDataObject(forCellNumber: Int) -> CategoryData {
        return CategoryViewModel.categoryRowDataArray[forCellNumber]
    }
}
