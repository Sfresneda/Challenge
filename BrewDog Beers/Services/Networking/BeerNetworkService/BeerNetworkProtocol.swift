//
//  BeerNetworkProtocol.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

/**
This error encapsulates the networking error and any other error from
this service
*/
enum BeerNetworkServiceError {
    case networkError(error: NetworkError)
}

/// The response for this service
enum BeerNetworkServiceResponse {
    case succeed(models: [Beer])
    case failure(error: BeerNetworkServiceError)
}

/// A protocol implementing the beers download
protocol BeerNetworkServiceProtocol {
    
    /// This function returns a page for the beers.
    /// - Parameters:
    ///   - url: the URL to retrieve
    ///   - completion: a completion block with the response
    func getBeersPage(request: URLRequest,
                      completion: @escaping ((BeerNetworkServiceResponse) -> ()))
}
