//
//  File.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
import XCTest

@testable import BrewDog_Beers

class BeerNetworkServiceTests: XCTestCase {
    var service: BeerNetworkServiceProtocol!
    
    override func setUp() {
        self.service = BeerNetworkService(networkingManager: NetworkManager.shared)
    }
    
    override func tearDown() {
        self.service = nil
    }
    
    func test_beers_transform_when_data_is_valid_transforms_to_valid_beers() {
        do{
            let data = try Data(contentsOf: Bundle(for: BeerNetworkServiceTests.self).url(forResource: "beers_valid", withExtension: ".json")!)
            let beers = try JSONDecoder().decode([Beer].self, from: data)
            
            let dataResponse = try Data(contentsOf: Bundle(for: BeerNetworkServiceTests.self).url(forResource: "beers_valid_response", withExtension: ".json")!)
            let beersResponse = try JSONDecoder().decode([BeerNetworkingServiceJSONResponse].self, from: dataResponse)
            
            let models = beersResponse.map{ $0.toDomainModel() }
            
            models.forEach{ (transformedModel) in
                XCTAssertTrue(transformedModel.isValid())
            }            
            XCTAssertEqual(beers, models)
        }
        catch{
            XCTFail("Error \(error)")
        }
    }
}
