//
//  CategoryViewController.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - Parameters
    var categoryViewModel: CategoryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         getCategoryDataFromWebService()
    }
    
    func getCategoryDataFromWebService() {
        NetworkManager.sharedInstance.getDataFromWebService { (responseData, error) in
            DispatchQueue.main.async {
                if responseData != nil {
                    self.categoryViewModel = CategoryViewModel(dataModel: responseData!)

                    self.navigationItem.title = self.categoryViewModel?.screenTitle
                } else {
                    let alert = UIAlertController(title: "Telstra POC", message: error?.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }


}

