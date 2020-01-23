//
//  NetworkCachingServiceTests.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
import XCTest

@testable import BrewDog_Beers

class NetworkCachingServiceTests: XCTestCase {
    var service: NetworkCachingServiceProtocol!
    
    override func setUp() {
        self.service = NetworkCachingService.shared
        NetworkCachingService.shared.clearCache()
    }
    
    override func tearDown() {
        self.service = nil
    }
    
    func tes_cache_when_data_is_valid_returns_existing_data(){
        do{
            let data = try Data(contentsOf: Bundle(for: NetworkCachingServiceTests.self).url(forResource: "beers_valid", withExtension: ".json")!)
            let beers = try JSONDecoder().decode([Beer].self, from: data)
            
            let expectation = self.expectation(description: "tes_cache_when_data_is_valid_returns_existing_data")
            
            let url = URL(string: "http://www.sergiofresneda.com")!
            self.service.setCache(url: url, data: NetworkCachingStruct(data: beers))
            self.service.getCacheObject(for: url){
                (cachedResponse:NetworkCachingStruct<[Beer]>?) in
                XCTAssertNotNil(cachedResponse)
                
                let models = cachedResponse?.data
                XCTAssertNotNil(models)
                models?.forEach{ (responseModel) in
                    XCTAssertTrue(responseModel.isValid())
                }
                
                XCTAssertEqual(models, beers)
                expectation.fulfill()
            }
            self.waitForExpectations(timeout: 30, handler: nil)
        }
        catch{
            XCTFail("Error \(error)")
        }
    }
    
    func test_cache_when_data_is_valid_and_clears_data_no_returns_data(){
        do{
            let data = try Data(contentsOf: Bundle(for: NetworkCachingServiceTests.self).url(forResource: "beers_valid", withExtension: ".json")!)
            let beers = try JSONDecoder().decode([Beer].self, from: data)
            
            let url = URL(string: "http://www.sergiofresneda.com")!
            self.service.setCache(url: url, data: NetworkCachingStruct(data: beers))
            self.service.clearCache()
            let expectation = self.expectation(description: "test_cache_when_data_is_valid_and_clears_data_no_returns_data")
            self.service.getCacheObject(for: url) {
                (cachedResponse:NetworkCachingStruct<Beer>?) in
                XCTAssertNil(cachedResponse)
                expectation.fulfill()
            }
            self.waitForExpectations(timeout: 30, handler: nil)
        }
        catch{
            XCTFail("Error \(error)")
        }
    }
}
