//
//  TelstraPOCTests.swift
//  TelstraPOCTests
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest
@testable import TelstraPOC

class TelstraPOCTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Test case to validate webservcie success call
    func testGetCategoryDataFromWebService() {
        let expectation = self.expectation(description: "Web Service response successful.")
        let categoryViewModel = CategoryViewModel()
        categoryViewModel.getCategoryData { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 7, handler: nil)
    }
}
