//
//  NetworkManager.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//


import Foundation

/**
 This class implements the protocol NetworkWrapper
 */
final class NetworkManager {
    
    // Singleton instance for the manager. It may allow to control the requests for the whole app. E.g.: cancel, modify priority, etc.
    static let shared = NetworkManager()
    
    // The session for the app
    let session:URLSession
    
    // Making this private ensures nobody can instantiate more than one NetworkService
    private init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = Config.shared.defaultNetworkingTimeOut
        session = URLSession(configuration: sessionConfiguration)
    }
}

extension NetworkManager:NetworkWrapper{
        
    func get<T:Decodable>(request: URLRequest,
                          completion: @escaping ((NetworkWrapperResult<T>)->())){
        
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            
            var result:NetworkWrapperResult<T> = .failed(.generalFailure)
            defer{
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard error == nil else { result = .failed(.networkingError(error: error!));  return }
            guard let response = urlResponse as? HTTPURLResponse else { result = .failed(.noResponse); return }
            guard (200 ..< 300) ~= response.statusCode else { result = .failed(.badStatus(code: response.statusCode)); return }
            
            if let data = data {
                do {
                    let responseJSON = try JSONDecoder().decode(T.self, from: data)
                    result = .succeed(responseJSON)
                } catch let error {
                    result = .failed(.dataDecodingFailure(error: error))
                }
            }
        }
        task.resume()
    }
}

