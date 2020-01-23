//
//  FindBeerPresenterTests.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
import XCTest
@testable import BrewDog_Beers

class FindBeerPresenterTests: XCTestCase {
    
    var view: FindBeerViewMock!
    var interactor: FindBeerInteractorMock!
    var presenter: FindBeerPresenter!
    var entity: FindBeerEntity!
    var wireframe: FindBeerWireframeMock!
    
    override func setUp() {
        self.view = FindBeerViewMock()
        self.interactor = FindBeerInteractorMock()
        self.presenter = FindBeerPresenter.init()
        self.entity = FindBeerEntity()
        self.wireframe = FindBeerWireframeMock()
        
        
        view.presenter = self.presenter
        
        interactor.presenter = self.presenter
        
        presenter.view = self.view
        presenter.interactor = interactor
        presenter.entity = self.entity
        presenter.wireframe = self.wireframe
        
        wireframe.view = self.view
        wireframe.presenter = presenter
    }
    
    override func tearDown() {
        self.view = nil
        self.interactor = nil
        self.presenter = nil
        self.entity = nil
        self.wireframe = nil
    }

    func test_viewDidLoad() {
        self.presenter.viewDidLoad()
        XCTAssertTrue(self.view.spyConfigure)
    }
    func test_changeSortBy() {
        self.presenter.changeSortBy()
        XCTAssertTrue(self.view.spyConfigure)
    }
    func test_wait_to_execute_queue_operation() {
        let expectation = XCTestExpectation(description: "test_wait_to_execute_queue_operation")
        expectation.expectedFulfillmentCount = 1
        self.presenter.newRequest(with: "test")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            XCTAssertNotNil(self.interactor.stubDoPerformGetBeersCompletion)
            XCTAssert(self.interactor.spyDoPerformGetBeers)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    func test_wait_to_show_loading_view() {
        let expectation = XCTestExpectation(description: "test_wait_to_show_loading_view")
        expectation.expectedFulfillmentCount = 1
        self.presenter.newRequest(with: "test")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            XCTAssertTrue(self.wireframe.spyShowLoading)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    func test_wait_to_hide_loading_view_show_error_and_show_no_results_view() {
        let expectation = XCTestExpectation(description: "test_wait_to_hide_loading_view_show_error_and_show_no_results_view")
        expectation.expectedFulfillmentCount = 1
        self.presenter.newRequest(with: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.interactor.stubDoPerformGetBeersCompletion?(.failure(error: .networkError(error: .networkError(error: .generalFailure))))
            
            XCTAssertTrue(self.wireframe.spyHideLoading)
            XCTAssertTrue(self.wireframe.spyShowError)
            XCTAssertTrue(self.view.spyNoResultsView)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    func test_wait_to_return_a_success_response() {
        let expectation = XCTestExpectation(description: "test_wait_to_return_a_success_response")
        expectation.expectedFulfillmentCount = 1
        self.presenter.newRequest(with: "test")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.interactor.stubDoPerformGetBeersCompletion?(.succeed(models: []))
            
            XCTAssertTrue(self.view.spyConfigure)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
    
}
