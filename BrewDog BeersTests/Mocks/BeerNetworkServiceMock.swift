//
//  BeerNetworkServiceMock.swift
//  BrewDog BeersTests
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import BrewDog_Beers

class BeerNetworkServiceMock: BeerNetworkServiceProtocol {
    var spyResult: Bool = false
    var stubResult: ((BeerNetworkServiceResponse) -> ())?
    
    func getBeersPage(request: URLRequest, completion: @escaping ((BeerNetworkServiceResponse) -> ())) {
        self.spyResult = true
        self.stubResult = completion
    }
}
