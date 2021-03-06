//
//  CategoryViewController.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    //MARK: - Variables
    var categoryViewModel = CategoryViewModel()
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator =  UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
        } else {
            activityIndicator.style = .gray
        }
        return activityIndicator
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performInitialSetup()
        
    }
    
    // MARK: - UITableView DataSource & Delegates
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.categoryCustomCellIdentifier, for: indexPath) as! CategoryCell
        cell.tag = indexPath.row
        cell.setCategoryData()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryViewModel.getCountOfCategoryData();
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: - Class Private Functions
    
    /// perform initital set of activities as view controller is loaded
    ///
    /// Use this method to perform all intial activites as view controller is loaded like setting up UI and making service call
    private func performInitialSetup() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CategoryCell.self, forCellReuseIdentifier: Constant.categoryCustomCellIdentifier)
        addActivityIndicator()
        addPullToRefreshControl()
        getCategoryDataFromViewModel()
    }
    
    /// Add activity indicator on navigation bar
    ///
    /// Use this method to add activity indicator on navigation bar
    private func addActivityIndicator(){
        //to set activity indicator on navigation bar
        let leftBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: true)
    }
    
    /// Fetch category data from category view model class
    ///
    /// Use this method to get data from ViewModel class and display response error if data is not in proper format
    private func getCategoryDataFromViewModel() {
        activityIndicator.startAnimating()
        categoryViewModel.getCategoryData {result in
            switch(result) {
            case .success:
                if(self.categoryViewModel.getCountOfCategoryData() > 0) {
                    self.title = self.categoryViewModel.screenTitle
                    self.tableView.reloadData()
                } else {
                    self.displayErrorMessageWith(messageString: NSLocalizedString("NoDataAvailable", comment: ""))
                }
            case .failure(let error):
                self.displayErrorMessageWith(messageString: error.localizedDescription)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    /// to set pull to refresh control
    ///
    /// Use this method to add pull to refresh conrol on view controller
    private func addPullToRefreshControl() {
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
    
    /// Method to dsiplay error messages on veiwcontroller
    ///
    /// - Parameter messageString: String to be used while displaying error message
    func displayErrorMessageWith(messageString:String) {
        let alert = UIAlertController(title: NSLocalizedString("ErrorHeader", comment: ""), message: messageString , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OkButton", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
