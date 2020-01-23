//
//  NetworkCachingervice.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

final class NetworkCachingService: NetworkCachingServiceProtocol {
    
    /// Singleton for the manager
    static let shared: NetworkCachingService = NetworkCachingService()
    
    /// We will implement it using userDefaults
    private let userDefaults: UserDefaults
    
    /// The suite name.
    private let suite: String = "com.fresneda.BrewDog-Beers.cache"
    
    private init() {
        self.userDefaults = UserDefaults(suiteName: suite)!
    }
    
    /// Remove all keys from userDefaults
    func clearCache()  {
        self.userDefaults.dictionaryRepresentation().forEach({ (key,_) in
            self.userDefaults.removeObject(forKey: key)
            
        })
    }
    
    func setCache<T>(url: URL, data: NetworkCachingStruct<T>) where T : Encodable {
        self.set(key: url.absoluteString, newValue: data.data)
    }
    
    func getCacheObject<T>(for url: URL,
                           completion: @escaping ((NetworkCachingStruct<T>?) -> ())) where T : Decodable {
        guard let data: T = self.get(key: url.absoluteString) else {
            completion(nil)
            return
        }
        completion(NetworkCachingStruct(data: data))
    }
}

extension NetworkCachingService {
    /// Helper to retrieve a decodable
    /// - Parameter key: the key to be retrieved
    private func get<T:Decodable>(key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    /// Helper to store an encodable
    /// - Parameters:
    ///   - key: the key
    ///   - newValue: the value to be stored
    private func set<T:Encodable>(key: String, newValue:T?){
        guard let value = newValue,
            let encondedValue = try? JSONEncoder().encode(value) else {
                userDefaults.removeObject(forKey: key)
                return
        }
        userDefaults.set(encondedValue, forKey: key)
    }
}
