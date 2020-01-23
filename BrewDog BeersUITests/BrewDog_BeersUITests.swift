//
//  BrewDog_BeersUITests.swift
//  BrewDog BeersUITests
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import XCTest

class BrewDog_BeersUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    override func tearDown() { }
    
    func test_app_ShowsBeers() {
        let app = XCUIApplication()
        app.launch()
        
        let beersTable = app.tables["beersTableView"]
        beersTable.searchFields["searchBar"].tap()
        
        app.keys["A"].tap()
        app.buttons["Search"].tap()
        
        let predicate = NSPredicate(format: "exists == true")
        let queryCell = beersTable.cells["cell_0"]
        
        expectation(for: predicate, evaluatedWith: queryCell, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssert(queryCell.exists)
    }
}
