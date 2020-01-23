//
//  NetworkingWrapper.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

/// Networking errors
enum NetworkError{
    case generalFailure
    case networkingError(error: Error)
    case noResponse
    case badStatus(code: Int)
    case noData
    case dataDecodingFailure(error: Error)
}

// Response Enum to return error with model data or failure with error
enum NetworkWrapperResult<T:Decodable> {
    case succeed(T)
    case failed(NetworkError)
}

// Network wrapper to make the calls
protocol NetworkWrapper {
    
    /// This function will make get calls to and endpoint and return a callback with the success of failure
    /// - Parameters:
    ///   - request: the paramters for the call
    ///   - completion: a completion block
    func get<S:Decodable>(request: URLRequest,
                completion: @escaping ((NetworkWrapperResult<S>)->()))
}
