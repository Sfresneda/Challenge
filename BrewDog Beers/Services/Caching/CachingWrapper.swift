//
//  CachingWrapper.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

/// This struct enclosures the cached object
struct NetworkCachingStruct<T> {
    let data: T
}

/// This protocol provides a cache service
protocol NetworkCachingServiceProtocol {
    
    /// Store data in the cache
    /// - Parameters:
    ///   - url: the url which will be used as key
    ///   - data: the data
    func setCache<T: Encodable> (url: URL, data: NetworkCachingStruct<T>)
    
    /// Get object from cache
    /// - Parameter url: the url used as key
    /// - Parameter completion: a callback with the result
    func getCacheObject<T: Decodable>(for url: URL,
                                 completion: @escaping ((NetworkCachingStruct<T>?) -> ()) )
    
    /// Clears the cache
    func clearCache()
}
