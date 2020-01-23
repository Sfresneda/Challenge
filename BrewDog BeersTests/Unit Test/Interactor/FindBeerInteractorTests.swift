//
//  FindBeerInteractorTests.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
import XCTest

@testable import BrewDog_Beers

class FindBeerInteractorTests: XCTestCase {
    var networkMock: BeerNetworkServiceMock!
    var cachingMock: NetworkCachingServiceMock!
    var interactor: FindBeerInteractorContract!
    
    override func setUp() {
        self.networkMock = BeerNetworkServiceMock()
        self.cachingMock = NetworkCachingServiceMock()
        self.interactor = FindBeerInteractor.init(networkService: self.networkMock,
                                                  cachingService: self.cachingMock)
    }
    
    override func tearDown() {
        self.networkMock = nil
        self.cachingMock = nil
        self.interactor = nil
    }
    
    func test_check_results_from_caching_and_network_services() {
        do {
            let data = try Data(contentsOf: Bundle(for: BeerNetworkServiceTests.self).url(forResource: "beers_valid", withExtension: ".json")!)
            let beers = try JSONDecoder().decode([Beer].self, from: data)
            
            let expectation = self.expectation(description: "test_check_results_from_caching_and_network_services")
            
            self.interactor.getBeerWith(request: .food("test")) { (result) in
                switch result {
                case .succeed(models: let models):
                    XCTAssertNotNil(models)
                    models.forEach{ (responseModel) in
                        XCTAssertTrue(responseModel.isValid())
                    }
                    XCTAssertEqual(beers, models)
                    
                case .failure(error: let error):
                    XCTFail("Operation failed: \(error)")
                }
                expectation.fulfill()
            }
            
            XCTAssertTrue(self.cachingMock.spyResult)
            self.cachingMock.stubResult?(nil)
            XCTAssertTrue(self.networkMock.spyResult)
            
            self.networkMock.stubResult?(.succeed(models: beers))
            self.waitForExpectations(timeout: 30, handler: nil)
        }
        catch{
            XCTFail("Error \(error)")
        }
    }
}
