//
//  CategoryViewController.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    //MARK: - Parameters
    var categoryViewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performInitialSetup()
        
    }
    
    // MARK: - UITableView DataSource & Delegates
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.categoryCustomCellIdentifier, for: indexPath) as! CategoryCell
        cell.setCategoryData(forCellNumber: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryViewModel.getCountOfCategoryData();
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    //MARK: - Other Functions
    
    /// perform initital set of activities as view controller is loaded
    ///
    /// Use this method to perform all intial activites as view controller is loaded like setting up UI and making service call
    func performInitialSetup() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CategoryCell.self, forCellReuseIdentifier: Constant.categoryCustomCellIdentifier)
        //to get JSON data from service
        addPullToRefreshControl()
        getCategoryDataFromViewModel()
    }
    
    /// Fetch category data from category view model class
    ///
    /// Use this method to get data from ViewModel class and display response error if data is not in proper format
    func getCategoryDataFromViewModel() {
        categoryViewModel.getCategoryData() {
            let resonceErrorString = self.categoryViewModel.getResponseError()
            if resonceErrorString == "" {
                self.title = self.categoryViewModel.getScreenTitleForTableView()
                self.tableView.reloadData()
            }  else {
                let alert = UIAlertController(title: "Telstra POC", message: resonceErrorString , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /// to set pull to refresh control
    ///
    /// Use this method to add pull to refresh conrol on view controller
    func addPullToRefreshControl() {
        //to add pull to refresh feature in applcaition
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: NSLocalizedString("RefreshHeader", comment: "String to display while pulling data") )
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(sender:)), for: UIControl.Event.valueChanged)
    }
    
    /// initiate pull to refresh mechanisum
    ///
    /// Use this method to refresh data on your view controller each time user perform pull to refresh action
    @objc func pullToRefresh(sender:AnyObject) {
        // Code to refresh table view
        getCategoryDataFromViewModel()
        self.refreshControl!.endRefreshing()
    }
}

